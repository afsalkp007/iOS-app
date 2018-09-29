//
//  StartViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isKeyPresentInUserDefaults(key: Constants.userDefaultsKeys.loggedInUser) {
            performSegue(withIdentifier: Constants.segues.ShowMainScreen, sender: nil)
        } else {
            performSegue(withIdentifier: Constants.segues.ShowLogin, sender: nil)
        }
    }
}
