//
//  GameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GameViewController: UIViewController {
	
	// MARK: - IBOutlets
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
	
	// MARK: - Variables
	
	var exercise: BehaviorRelay<Exercise> = BehaviorRelay(value: Exercise())
	
	// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
		//TODO: Bind exercise to view
        answerTextField.addDoneButtonToKeyboard(myAction:  #selector(self.answerTextField.resignFirstResponder))
    }
}

