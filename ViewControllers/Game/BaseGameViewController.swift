//
//  BaseGameViewController.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 16..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseGameViewController: UIViewController {
	
	// MARK: - IBOutlets
	@IBOutlet var timerLabel: UILabel!
	@IBOutlet var gameWrapperView: UIView!
	
	var difficultyLevel: DifficultyLevel?
	let exercises: BehaviorRelay<[Exercise]> = BehaviorRelay(value: [])
	let disposeBag = DisposeBag()

	@IBAction func closeGame(_ sender: Any) {
		dismissView()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		RestClient.getExercises(for: difficultyLevel ?? .beginner, with: self)
    }
	
	// MARK: - Navigation
	
	func dismissView() {
		let popup = UIAlertController(title: "Stop Game", message: "Are you sure you want to quit?", preferredStyle: .alert)
		popup.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (action) in
			self?.dismiss(animated: true, completion: nil)
		}))
		
		popup.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
			popup.removeFromParent()
		}))
		
		self.present(popup, animated: true, completion: nil)
	}
}

extension BaseGameViewController: GameDelegate {
	func getExercisesDidSuccess(exercises: [Exercise]) {
		//TODO: update datasource
		self.exercises.accept(exercises)
		
		//TODO: Hide loading, show first question
	}
	
	func getExercisesDidFail(with error: Error?) {
		NSLog("😢 get exercises did fail: \(String(describing: error))")
	}
}
