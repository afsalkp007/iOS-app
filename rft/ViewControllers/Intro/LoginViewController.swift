//
//  LoginViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import AudioToolbox
import UIKit

class LoginViewController: UIViewController {

	// MARK: - IBOutlets

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: ShadowButton!
    @IBOutlet var registerButton: UIButton!

	// MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.shouldHideKeyboard(onTap: true)
		self.view.shouldHideKeyboard(onSwipeDown: true)
        passwordTextField.addTarget(self, action: #selector(login), for: UIControl.Event.editingDidEndOnExit)
    }

    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = 2
    }

	// MARK: - IBActions for user input

    @IBAction func userNameTextFieldEditingDidBegin(_ sender: Any) {
        loginButton.isEnabled = true
        loginButton.alpha = 1.0
    }

    @IBAction func passwordTextFieldEditingDidBegin(_ sender: Any) {
        loginButton.isEnabled = true
        loginButton.alpha = 1.0
    }

    @IBAction func didPressLoginButton(_ sender: Any) {
       login()
    }

	// MARK: - Functionality

    @objc
    private func login() {
        hideKeybard()
		RestClient.login(with: userNameTextField.text ?? "", password: passwordTextField.text ?? "", with: self)
    }

	// MARK: - Helper methods

    @objc
    private func hideKeybard() {
        self.view.endEditing(true)
    }
}

// MARK: - RestClient delegate

extension LoginViewController: LoginDelegate {
	func loginDidSuccess(response: MyUser) {
		Constants.kAppDelegate.loggedInUser = response
		self.performSegue(withIdentifier: Constants.Segues.LoginToMainScreen, sender: self)
	}

	func loginDidFail(with error: Error?) {
		NSLog("😢 \(String(describing: error))")
		loginButton.isEnabled = false
		loginButton.alpha = 0.5

		AudioServicesPlaySystemSound(1521)

		userNameTextField.shake()
		passwordTextField.shake()
	}
}
