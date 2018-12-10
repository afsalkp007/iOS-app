//
//  MyUser.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MyUser: BaseModel {
    var name: String?
	var email: String?
	var token: String?
    var topScore: String?
	var time: Float?

	init() {}

	init(json: JSON) {
		self.name = json["name"].rawString()
		self.time = json["time"].floatValue
		self.topScore = json["score"].rawString()
	}

	init(with data: JSON) {
		self.name = data["name"].stringValue
		self.email = data["email"].stringValue
		self.token = data["token"].stringValue
	}
}
