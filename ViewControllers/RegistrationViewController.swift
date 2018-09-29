//
//  RegistrationViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addTarget(self, action: #selector(register), for: UIControl.Event.editingDidEndOnExit)
        
    }
    
    @IBAction func didPressSignUpButton(_ sender: Any) {
        register()
    }
    
    @objc
    private func register() {
        hideKeybard()
        guard let email = emailTextField.text else {
            //TODO: email not ok
            return
        }
        guard let password = passwordTextField.text else {
            //TODOL password not ok
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            // ...
            guard let user = authResult?.user else {
                NSLog("😢 \(String(describing: error))")
                return
            }
            
            NSLog("👌 \(String(describing: user.email)) created")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.loggedInUser = user
            self?.performSegue(withIdentifier: Constants.segues.RegisterToMainScreen, sender: nil)
            
        }
    }
    
    private func hideKeybard() {
        self.view.endEditing(true)
    }
}
