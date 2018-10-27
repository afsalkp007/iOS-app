//
//  MainMenuViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Firebase
import RxCocoa
import RxSwift
import SVProgressHUD
import UIKit

class MainMenuViewController: UIViewController {
	
	// MARK: - IBOutlets

    @IBOutlet var tableView: UITableView!
    @IBOutlet var startButton: ShadowButton!
	
	// MARK: - Variables
    
    let difficulties: BehaviorRelay<[Difficulty]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDatasource()
        setupTableView()
        setupStartButton()
        setupNotifications()
    }
	
	// MARK: - Setup methods
    
    func setUpDatasource() {
        difficulties.accept(DifficultyProvider.sharedInstance().getDifficulties())
        
        difficulties.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: Constants.Cells.DifficultyCell)) { [weak self] (index, model, cell: DifficultyCell) in
            self?.bind(to: cell, with: model)
            cell.wrapperView.clipsToBounds = false
            cell.wrapperView.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            cell.wrapperView.layer.shadowOpacity = 0.3
            cell.wrapperView.layer.shadowOffset = CGSize(width: 0, height: 2)
            }.disposed(by: disposeBag)
    }
    
    func setupTableView() {
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            NSLog("✅ Row \(indexPath.row) selected")
        }).disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
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
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(startButtonTapped), name: Constants.Notifications.StartButtonDidTouchUpInside, object: nil)
    }
    
    //MARK: - Navigation
	
    @objc private func startButtonTapped() {
        if let selectedLevel = tableView.indexPathForSelectedRow?.row {
            NSLog("💥 Start button tapped for level \(String(describing: selectedLevel))")
            performSegue(withIdentifier: Constants.Segues.StartGame, sender: nil)
            //TODO: [RestClient loadExercisesForLevel: selectedLevel]
        } else {
            //TODO: error please select a level
            NSLog("😢 No level selected.")
        }
    }
}

// MARK: - Cell binding

extension MainMenuViewController: DifficultyCellBinding {
    func bind(to cell: DifficultyCell, with model: Difficulty) {
        cell.titleLabel.text = model.name
        cell.levelImageView.image = model.image
		cell.wrapperView.backgroundColor = model.color
    }
}

// MARK: - TableView delegate

extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
