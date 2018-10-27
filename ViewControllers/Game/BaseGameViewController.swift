//
//  BaseGameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 16..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import RxCocoa
import RxSwift
import SVProgressHUD
import UIKit

class BaseGameViewController: UIViewController {

	// MARK: - IBOutlets
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var gameWrapperView: UIView!

	// MARK: - Variables

	var difficultyLevel: DifficultyLevel?
	let exercises: BehaviorRelay<[Exercise]> = BehaviorRelay(value: [])
	let disposeBag = DisposeBag()

	// MARK: - View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		RestClient.getExercises(for: difficultyLevel ?? .beginner, with: self)
		SVProgressHUD.show()
	}

	// MARK: - Navigation

	@IBAction func closeGame(_ sender: Any) {
		dismissView()
	}

	func dismissView() {
		let popup = UIAlertController(title: "Stop Game", message: "Are you sure you want to quit?", preferredStyle: .alert)
		let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (_) in
			self?.dismiss(animated: true, completion: nil)
		})
		let noAction = UIAlertAction(title: "No", style: .cancel, handler: { (_) in
			popup.removeFromParent()
		})
		popup.addAction(yesAction)
		popup.addAction(noAction)
		self.present(popup, animated: true, completion: nil)
	}
}

// MARK: - RestClient delegate

extension BaseGameViewController: GameDelegate {
	func getExercisesDidSuccess(exercises: [Exercise]) {
		self.exercises.accept(exercises)
		SVProgressHUD.dismiss()
	}

	func getExercisesDidFail(with error: Error?) {
		NSLog("😢 get exercises did fail: \(String(describing: error))")
	}
}
