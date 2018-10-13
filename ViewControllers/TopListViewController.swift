//
//  TopListViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TopListViewController: UIViewController {
    
    @IBOutlet var levelChooser: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    let topUsers: BehaviorRelay<[MyUser]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupTableView()
    }
    
    @IBAction func levelSelected(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        NSLog("\(index)")
    }
    
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
}
