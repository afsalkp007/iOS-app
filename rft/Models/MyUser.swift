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
    var position: Int?
    var name: String?
	var email: String?
    var topScore: String?
	var token: String?
	
	init() {}

	init(json: JSON) {
		self.name = json["name"].rawString()
		self.position = json["position"].intValue
		self.topScore = json["topScore"].rawString()
	}
}
