//
//  BaseGameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 16..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import SRCountdownTimer
import SwiftyTimer
import UIKit

class BaseGameViewController: UIViewController {

	// MARK: - IBOutlets

	@IBOutlet private var timerLabel: UILabel!
	@IBOutlet private var gameWrapperView: UIView!
    @IBOutlet private var countdownView: SRCountdownTimer!
	@IBOutlet private var finishButton: UIButton!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!

	// MARK: - Variables

	var difficultyLevel: DifficultyLevel?
	let exercises: BehaviorRelay<[Exercise]> = BehaviorRelay(value: [])
	let disposeBag = DisposeBag()
	var gameViewController: GameViewController?
	var currentExercise = 0
	var correctAnswers = 0
	var timer: Timer?
	var start: Date?
	var end: Date?

	// MARK: - View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		RestClient.getExercises(for: difficultyLevel ?? .beginner, with: self)
		subscribeToNotifications()
        showLoading(true)
		finishButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
		timer = Timer.new(every: 1.ms) { [weak self] in
			let progress = Date().timeIntervalSince(self?.start ?? Date())
			let timeText = String(format: "%.2f s", progress)
			self?.timerLabel.text = timeText
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	// MARK: - Init

	private func subscribeToNotifications() {
		NotificationCenter.default
			.addObserver(self,
						selector: #selector(addGameView(_:)),
						name: Constants.Notifications.FinishedCurrentExecise, object: nil)
	}

	// MARK: - Setup game

	@objc private func addGameView(_ sender: Notification = Notification(name: Notification.Name(rawValue: "")) ) {

		if let userInfo = sender.userInfo {
			if let isCorrect = userInfo["isCorrect"] as? Bool {
				if isCorrect {
					correctAnswers += 1
				}
			}
		}

		guard currentExercise < exercises.value.count else {
			endTimer()
			timerLabel.blink()
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
				self?.timerLabel.layer.removeAllAnimations()
				self?.timerLabel.text = "Correct: \(self?.correctAnswers ?? 0) out of \(self?.exercises.value.count ?? 0)"
			}

			gameViewController?.answerTextField.isUserInteractionEnabled = false
			gameViewController?.answerTextField.alpha = 0

			finishButton.isUserInteractionEnabled = true
			finishButton.alpha = 1

			let time = Date().timeIntervalSince(self.start ?? Date())
			let correctAnswers = UInt(self.correctAnswers)
			print("✅ correct answers: \(correctAnswers)")
			let result = GameResult(time: time, correctAnswers: correctAnswers)
			if let difficulty = self.difficultyLevel {
				RestClient.post(result, for: difficulty, success: { response in
					let result = response["score"].numberValue
					self.gameViewController?.questionLabel.text = "Score: \(result)"
				},fail: { error in
					NSLog(error.localizedDescription)
				})
			}
			return
		}
		let exercise = exercises.value[currentExercise]
		gameViewController?.exercise.accept(exercise)
		currentExercise += 1
	}

	// MARK: - Manage game

	private func startCountdown() {
		countdownView.timerFinishingText = "GO"
		countdownView.delegate = self
		countdownView.start(beginingValue: 3)
	}

	private func startGame() {
		gameViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.GameViewController) as? GameViewController
		gameWrapperView.addSubview(gameViewController?.view ?? UIView())
		gameViewController?.view.snp.makeConstraints({ make in
			make.edges.equalTo(gameWrapperView)
		})
		gameViewController?.answerTextField.becomeFirstResponder()
		addGameView()
		startTimer()
	}

	// MARK: - Time measuring

	private func startTimer() {
		start = Date()
		timer?.start(modes: RunLoop.Mode.default)
	}

	private func endTimer() {
		timer?.invalidate()
		end = Date()
	}

	// MARK: - Navigation

	@IBAction private func closeGame(_ sender: Any) {
		let popup = UIAlertController(title: "Stop Game", message: "Are you sure you want to quit?", preferredStyle: .alert)
		let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
			self?.dismissView()
		})
		let noAction = UIAlertAction(title: "No", style: .cancel, handler: { _ in
			popup.removeFromParent()
		})
		popup.addAction(yesAction)
		popup.addAction(noAction)
		self.present(popup, animated: true, completion: nil)
	}

	@objc private func dismissView() {
		dismiss(animated: true, completion: nil)
	}

    // MARK: - Loading indicator
    private func showLoading(_ show: Bool) {
        if show {
            loadingIndicator.alpha = 1.0
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.alpha = 0.0
            loadingIndicator.stopAnimating()
        }
    }
}

// MARK: - RestClient delegate

extension BaseGameViewController: GameDelegate {
	func getExercisesDidSuccess(exercises: [Exercise]) {
		NSLog("🙌 get exercises did succes)")
		self.exercises.accept(exercises)
        showLoading(false)
		startCountdown()
	}

	func getExercisesDidFail(with error: Error?) {
		NSLog("😢 get exercises did fail: \(String(describing: error))")
		showLoading(true)
		RestClient.getExercises(for: self.difficultyLevel ?? .beginner, with: self)
	}
}

// MARK: - SRCountdownTimer Delegate

extension BaseGameViewController: SRCountdownTimerDelegate {
	func timerDidEnd() {
		UIView.animate(withDuration: 0.5, animations: { [weak self] in
			self?.countdownView.alpha = 0
			}, completion: { _ in
			self.startGame()
			self.countdownView.removeFromSuperview()
		})
	}
}
