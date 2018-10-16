//
//  GameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
	
	// MARK: - IBOutlets
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerTextField: UITextField!
    
    
    @IBAction func dismissGame(_ sender: Any) {
        self.dismissView()
    }
	
	// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.addDoneButtonToKeyboard(myAction:  #selector(self.answerTextField.resignFirstResponder))
    }
	
	// MARK: - Navigation
	
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

extension GameViewController: GameDelegate {
	func getExercisesDidSuccess(exercises: [Exercise]) {
		//TODO: update datasource
	}
	
	func getExercisesDidFail(with error: Error?) {
		NSLog("😢 get exercises did fail: \(String(describing: error))")
	}
}
