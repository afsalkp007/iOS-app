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
        self.dismissView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.addDoneButtonToKeyboard(myAction:  #selector(self.answerTextField.resignFirstResponder))
    }
    
    func dismissView() {
        let popup = UIAlertController(title: "Stop Game", message: "Are you sure you want to quit?", preferredStyle: .alert)
        popup.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }))
        
        popup.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            popup.removeFromParent()
        }))
        
        self.present(popup, animated: true, completion: nil)
    }
}
