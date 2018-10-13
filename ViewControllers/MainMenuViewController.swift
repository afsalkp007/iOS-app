//
//  MainMenuViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Firebase
import RxSwift

class MainMenuViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = appDelegate.loggedInUser
        if let username = user?.displayName {
            userNameLabel.text = "Welcome \(username)"
        } else if let userEmail = user?.email {
            userNameLabel.text = "Welcome \(userEmail)"
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            Constants.kAppDelegate.defaults.removeObject(forKey: Constants.userDefaultsKeys.loggedInUser)
            performSegue(withIdentifier: Constants.segues.Logout, sender: self)
        } catch {
            NSLog("😢 logout failed")
        }
    }
}
