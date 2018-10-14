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
    @IBOutlet var signUpButton: ShadowButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addTarget(self, action: #selector(register), for: UIControl.Event.editingDidEndOnExit)
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeybard))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideKeybard))
        swipeDown.direction = .down
        
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @IBAction func emailTextFieldDidBeginEditing(_ sender: Any) {
        signUpButton.isEnabled = true
        signUpButton.alpha = 1.0
    }
    
    @IBAction func passwordTextFielDidBeginEditing(_ sender: Any) {
        signUpButton.isEnabled = true
        signUpButton.alpha = 1.0
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
                self?.signUpButton.isEnabled = false
                self?.signUpButton.alpha = 0.5
                
                self?.emailTextField.shake()
                self?.passwordTextField.shake()
                
//                self?.emailTextField.layer.borderColor = UIColor.red.cgColor
//                self?.emailTextField.layer.borderWidth = 1.0
//                self?.emailTextField.layer.cornerRadius = 4.0
//                self?.passwordTextField.layer.borderColor = UIColor.red.cgColor
//                self?.passwordTextField.layer.borderWidth = 1.0
//                self?.passwordTextField.layer.cornerRadius = 4.0
                
                return
            }
            
            NSLog("👌 \(String(describing: user.email)) created")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.loggedInUser = user
            self?.performSegue(withIdentifier: Constants.Segues.RegisterToMainScreen, sender: nil)
            
        }
    }
    
    @objc
    private func hideKeybard() {
        self.view.endEditing(true)
    }
    
//    private func resetColors() {
//        emailTextField.layer.borderWidth = 0.0
//        passwordTextField.layer.borderWidth = 0.0
//        emailTextField.layer.borderColor = UIColor.clear.cgColor
//        passwordTextField.layer.borderColor = UIColor.clear.cgColor
//    }
}
