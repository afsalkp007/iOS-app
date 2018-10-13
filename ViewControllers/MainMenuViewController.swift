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

    @IBOutlet var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
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
