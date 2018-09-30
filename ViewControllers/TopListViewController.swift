//
//  TopListViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Crashlytics

class TopListViewController: UIViewController {

    @IBAction func crashButton(_ sender: Any) {
        Crashlytics.sharedInstance().crash()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
