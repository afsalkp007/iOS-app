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

	@IBAction func didEnterAnswer(_ sender: Any) {
		answerTextField.text = ""
		NotificationCenter.default.post(name: Constants.Notifications.FinishedCurrentExecise, object: nil)
	}
}
