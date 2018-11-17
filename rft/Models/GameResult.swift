//
//  GameResult.swift
//  rft
//
//  Created by Levente Vig on 2018. 11. 17..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

struct GameResult: BaseModel {
	var time: Double
	var correctAnswers: UInt

	init(time: Double, correctAnswers: UInt) {
		self.time = time
		self.correctAnswers = correctAnswers
	}
}
