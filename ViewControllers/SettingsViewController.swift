//
//  SettingsViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    

//    do {
//    try Auth.auth().signOut()
//    Constants.kAppDelegate.defaults.removeObject(forKey: Constants.userDefaultsKeys.loggedInUser)
//    performSegue(withIdentifier: Constants.segues.Logout, sender: self)
//    } catch {
//    NSLog("😢 logout failed")
//    }

}
