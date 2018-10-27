//
//  LoginViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Firebase
import GoogleSignIn
import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {
	
	// MARK: - IBOutlets
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: ShadowButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var googleLoginButton: GIDSignInButton!

	// MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        self.view.shouldHideKeyboard(onTap: true)
		self.view.shouldHideKeyboard(onSwipeDown: true)
        passwordTextField.addTarget(self, action: #selector(login), for: UIControl.Event.editingDidEndOnExit)
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = 2
    }
	
	// IBActions for user input
    
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
        Auth.auth().signIn(withEmail: userNameTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] (result, error) in
            if let error = error {
                NSLog("😢 \(error)")
                self?.loginButton.isEnabled = false
                self?.loginButton.alpha = 0.5
                
                self?.userNameTextField.shake()
                self?.passwordTextField.shake()
            } else {
                NSLog("👌 \(String(describing: result?.user.email)) successfully logged in.")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.loggedInUser = result?.user
                self?.performSegue(withIdentifier: Constants.Segues.LoginToMainScreen, sender: self)
            }
            return
        }
    }

	// MARK: - Helper methods
	
    @objc
    private func hideKeybard() {
        self.view.endEditing(true)
    }
	
	// MARK: - Future features
    
    @IBAction func didPressGoogleLoginButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}
