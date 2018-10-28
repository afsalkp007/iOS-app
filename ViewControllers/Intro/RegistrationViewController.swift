//
//  RegistrationViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Firebase
import UIKit

class RegistrationViewController: UIViewController {

	// MARK: - IBOutlets

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: ShadowButton!

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.shouldHideKeyboard(onTap: true)
		self.view.shouldHideKeyboard(onSwipeDown: true)
        passwordTextField.addTarget(self, action: #selector(register), for: UIControl.Event.editingDidEndOnExit)
    }

	// MARK: IBActions for user interactions

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

	// MARK: - Functionality

    @objc
    private func register() {
        hideKeybard()
        guard let email = emailTextField.text else {
			NSLog("😢 email wrong")
            return
        }
        guard let password = passwordTextField.text else {
			NSLog("😢 password wrong")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            // ...
            guard let user = authResult?.user else {
                NSLog("😢 \(String(describing: error))")
                self?.signUpButton.isEnabled = false
                self?.signUpButton.alpha = 0.5

                self?.emailTextField.shake()
                self?.passwordTextField.shake()

                return
            }

            NSLog("👌 \(String(describing: user.email)) created")
            Constants.kAppDelegate.loggedInUser = user
            self?.performSegue(withIdentifier: Constants.Segues.RegisterToMainScreen, sender: nil)
        }
    }

	// MARK: - Helper methods

    @objc
    private func hideKeybard() {
        self.view.endEditing(true)
    }
}
