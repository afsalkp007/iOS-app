//
//  TopListViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import PullToRefreshKit
import RxCocoa
import RxSwift
import UIKit

class TopListViewController: UIViewController {

	// MARK: - IBOutlets

    @IBOutlet var levelChooser: UISegmentedControl!
    @IBOutlet var tableView: UITableView!

	// MARK: - Variables

    let topUsers: BehaviorRelay<[MyUser]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    var level: DifficultyLevel = .beginner

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatasource()
        setupTableView()
    }

	// MARK: - Setup methods

    func setupDatasource() {
        RestClient.getTopList(for: level, with: self)
        topUsers.asObservable()
		.bind(to: self.tableView.rx
		.items(cellIdentifier: Constants.Cells.TopListCell)) { [weak self] (_, model, cell: TopListCell) in
            self?.bind(to: cell, with: model)
            }.disposed(by: disposeBag)
    }

    func setupTableView() {
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }).disposed(by: disposeBag)
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        tableView.configRefreshHeader(container: self) { [weak self] in
            RestClient.getTopList(for: self!.level , with: self!)
            self?.tableView.switchRefreshHeader(to: .normal(.success, 0.5))
        }
    }

    // MARK: - Level chooser

    @IBAction func levelSelected(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        level = DifficultyLevel(rawValue: index) ?? .beginner
        NSLog("🌍 loading top list for level \(index)")
        RestClient.getTopList(for: level, with: self)
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
