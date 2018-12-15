//
//  RegistrationViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import AudioToolbox
import UIKit

class RegistrationViewController: UIViewController {

	// MARK: - IBOutlets

	@IBOutlet var usernameTextField: UITextField!
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
		guard let name = usernameTextField.text else {
			NSLog("😢 username missing")
			return
		}
        guard let email = emailTextField.text else {
			NSLog("😢 email missing")
            return
        }
        guard let password = passwordTextField.text else {
			NSLog("😢 password missing")
            return
        }

		RestClient.register(with: name, password: password, email: email, with: self)
    }

	// MARK: - Helper methods

    @objc
    private func hideKeybard() {
        self.view.endEditing(true)
    }
}

extension RegistrationViewController: LoginDelegate {
	func loginDidSuccess(response: MyUser) {
		Constants.kAppDelegate.loggedInUser = response
		self.performSegue(withIdentifier: Constants.Segues.RegisterToMainScreen, sender: nil)
	}

	func loginDidFail(with error: Error?) {
		NSLog("😢 \(String(describing: error))")
		signUpButton.isEnabled = false
		signUpButton.alpha = 0.5

		AudioServicesPlaySystemSound(1521)

		usernameTextField.shake()
		emailTextField.shake()
		passwordTextField.shake()
	}
}
