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

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = 8
    }
    
    @IBAction func didEnterPassword(_ sender: Any) {
        hideKeybard()
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        hideKeybard()
    }
    
    private func hideKeybard() {
        self.view.endEditing(true)
    }
    
    @IBAction func didPressGoogleLoginButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}
