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
    var level: DifficultyLevel = .beginner
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RestClient.sharedInstance().getTopList(for: level, with: self)
        
        topUsers.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.TopListCell)) { [weak self] (index, model, cell: TopListCell) in
            self?.bind(to: cell, with: model)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)

        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Level chooser
    
    @IBAction func levelSelected(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        level = DifficultyLevel(rawValue: index) ?? .beginner
        NSLog("🌍 loading top list for level \(index)")
        RestClient.sharedInstance().getTopList(for: level, with: self)
    }
}

// MARK: - Protocol implementations

extension TopListViewController: TopListCellBinding {
    func bind(to cell: TopListCell, with model: MyUser) {
        cell.nameLabel.text = model.name
        cell.positionLabel.text = "\(model.position ?? 0)."
        cell.timeLabel.text = model.topScore
    }
}

extension TopListViewController: TopListDelegate {
    
    func getTopListDidSuccess(users: [MyUser]) {
        topUsers.accept(users)
    }
    
    func getTopListDidFail(error: Error?) {
        NSLog("😢 getTopListDidFail: \(String(describing: error))")
    }
}
