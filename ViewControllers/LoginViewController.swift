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
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        passwordTextField.addTarget(self, action: #selector(login), for: UIControl.Event.editingDidEndOnExit)
    }
    
    override func viewDidLayoutSubviews() {
        loginButton.layer.cornerRadius = 2
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
       login()
    }
    
    @objc
    private func login() {
        hideKeybard()
        Auth.auth().signIn(withEmail: userNameTextField.text ?? "", password: passwordTextField.text ?? "") { (result, error) in
            if let error = error {
                NSLog("😢 \(error)")
            }
            NSLog("👌 \(String(describing: result?.user.email)) successfully logged in.")
            return
        }
    }
    
    private func hideKeybard() {
        self.view.endEditing(true)
    }
    
    @IBAction func didPressGoogleLoginButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func didPressRegisterButton(_ sender: Any) {
        NSLog("☺️ register pressed")
    }
    
}
