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

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		//TODO: Bind exercise to view
        answerTextField.addDoneButtonToKeyboard(myAction:  #selector(self.answerTextField.resignFirstResponder))
    }
}
