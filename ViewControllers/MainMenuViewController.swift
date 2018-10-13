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
import RxCocoa

class MainMenuViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var startButton: UIButton!
    
    let difficulties: BehaviorRelay<[Difficulty]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var diff1 = Difficulty()
        diff1.name = "easy"
        
        var diff2 = Difficulty()
        diff2.name = "intermediate"
        
        
        difficulties.accept([diff1, diff2])
        
        difficulties.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.DifficultyCell)) { [weak self] (index, model, cell: DifficultyCell) in
            self?.bind(to: cell, with: model)
        }.disposed(by: disposeBag)
        
//        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
//            let row = indexPath.row
//            NSLog("✅ \(row) row selected")
//        }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let row = indexPath.row
            NSLog("✅ Row \(row) selected")
            self.tableView.deselectRow(at: indexPath, animated: false)
        }).disposed(by: disposeBag)
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        NSLog("💥 Start button tapped")
    }
}

extension MainMenuViewController: DifficultyCellBinding {
    func bind(to cell: DifficultyCell, with model: Difficulty) {
        cell.titleLabel.text = model.name
        cell.levelImageView.image = model.image
    }
}

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
