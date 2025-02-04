//
//  GameDelegate.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 16..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

protocol GameDelegate: NSObjectProtocol {
	func getExercisesDidSuccess(exercises: [Exercise])
	func getExercisesDidFail(with error: Error?)
}
