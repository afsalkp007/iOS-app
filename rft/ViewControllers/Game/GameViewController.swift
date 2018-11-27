//
//  GameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class GameViewController: UIViewController {

	// MARK: - IBOutlets

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!

	// MARK: - Variables

	var exercise: BehaviorRelay<Exercise> = BehaviorRelay(value: Exercise())
	let disposeBag = DisposeBag()

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		exercise
			.map({ $0.question })
			.asObservable()
			.bind(to: questionLabel.rx.text)
			.disposed(by: disposeBag)

		answerTextField.addDoneButtonToKeyboard(with: self, myAction: #selector(self.didEnterAnswer(_:)))
    }

	@objc private func didEnterAnswer(_ sender: Any) {
		var isCorrect = false
		if let answerText = answerTextField?.text {
			if let answer = Double(answerText) {
				if answer == exercise.value.correctAnswer {
					isCorrect = true
				}
			}
		}

		let userinfo = ["isCorrect" : isCorrect]
		NotificationCenter.default.post(name: Constants.Notifications.FinishedCurrentExecise, object: self, userInfo: userinfo)
		answerTextField?.text = ""
	}
}
