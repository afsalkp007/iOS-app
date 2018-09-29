//
//  MainMenuViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    
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
}
