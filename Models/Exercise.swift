//
//  Exercise.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Exercise: BaseModel {
    var question: String?
    var correctAnswer: Double?

	init() {}

	init(json: JSON) {
		self.question = json[""].rawString()
		self.correctAnswer = json[""].doubleValue
	}
}
