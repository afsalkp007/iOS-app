//
//  SettingsViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let settingsItems: BehaviorRelay<[SettingsItem]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsItems.accept(SettingsItemProvider.sharedInstance().getSettingsItems())
        
        settingsItems.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.SettingsCell)) { [weak self] (index, model, cell: SettingsCell) in
            self?.bind(to: cell, with: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            let row = indexPath.row
            if row == 1 {
                self?.logout()
            }
            
            
        }).disposed(by: disposeBag)
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    
    
    // MARK: - Navigation
    @objc private func logout() {
        do {
            try Auth.auth().signOut()
            Constants.kAppDelegate.defaults.removeObject(forKey: Constants.userDefaultsKeys.loggedInUser)
            performSegue(withIdentifier: Constants.segues.Logout, sender: self)
            FBSDKLoginManager.init().logOut()
            NSLog("✅ logout complete")
        } catch {
            NSLog("😢 logout failed")
        }
    }
    
}

extension SettingsViewController: SettingsCellBinding {
    func bind(to cell: SettingsCell, with model: SettingsItem) {
        cell.titleLabel.text = model.title
        cell.imageView?.image = model.image
    }
}
