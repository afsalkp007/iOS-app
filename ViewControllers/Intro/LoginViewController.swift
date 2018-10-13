//
//  LoginViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: ShadowButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var googleLoginButton: GIDSignInButton!
    @IBOutlet var fbLoginButton: FBSDKLoginButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email"]
        addGestureRecognizers()
        passwordTextField.addTarget(self, action: #selector(login), for: UIControl.Event.editingDidEndOnExit)
    }
    
    private func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeybard))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideKeybard))
        swipeDown.direction = .down
        
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = 2
    }
    
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
                self?.performSegue(withIdentifier: Constants.segues.LoginToMainScreen, sender: self)
            }
            return
        }
    }
    
    @objc
    private func hideKeybard() {
        self.view.endEditing(true)
    }
    
    @IBAction func didPressGoogleLoginButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //TODO: Implement Logout
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let userName = FBSDKProfile.current()?.name
        NSLog("\(userName) successfully logged in.")
        
        
//        self.performSegue(withIdentifier: Constants.segues.LoginToMainScreen, sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainTabbarController")
        self.present(controller, animated: true, completion: nil)
    }
}
