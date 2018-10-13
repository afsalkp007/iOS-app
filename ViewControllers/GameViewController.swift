//
//  GameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    
    @IBAction func dismissGame(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.addDoneButtonToKeyboard(myAction:  #selector(self.answerTextField.resignFirstResponder))
    }
}
