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
    @IBOutlet var startButton: ShadowButton!
    
    let difficulties: BehaviorRelay<[Difficulty]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var diff1 = Difficulty()
        diff1.name = "easy"
        var diff2 = Difficulty()
        diff2.name = "intermediate"
        difficulties.accept([diff1, diff2])
        
        difficulties.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.DifficultyCell)) { [weak self] (index, model, cell: DifficultyCell) in
            self?.bind(to: cell, with: model)
            cell.wrapperView.clipsToBounds = false
            cell.wrapperView.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            cell.wrapperView.layer.shadowOpacity = 0.3
            cell.wrapperView.layer.shadowOffset = CGSize(width: 0, height: 2)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            NSLog("✅ Row \(indexPath.row) selected")
        }).disposed(by: disposeBag)
        
        setupTableView()
        setupStartButton()
    }
    
    func setupTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    func setupStartButton() {
        startButton.clipsToBounds = false
        startButton.layer.cornerRadius = 8
        startButton.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        startButton.layer.shadowOpacity = 0.3
        startButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    
    
    //MARK: - Navigation
    @IBAction func startButtonTapped(_ sender: Any) {
        if let selectedLevel = tableView.indexPathForSelectedRow?.row {
            NSLog("💥 Start button tapped for level \(String(describing: selectedLevel))")
            //TODO: [RestClient loadExercisesForLevel: selectedLevel]
        } else {
            //TODO: error please select a level
        }
    }
    
    
    //MARK: - RestClient
    
    
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
