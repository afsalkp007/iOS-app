//
//  Difficulty.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

struct Difficulty: BaseModel {
    var level: DifficultyLevel?
    var name: String?
    var image: UIImage?
	var color: UIColor?
}
