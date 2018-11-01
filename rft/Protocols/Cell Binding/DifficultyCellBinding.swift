//
//  DifficultyCellBinding.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

protocol DifficultyCellBinding {
    func bind(to cell: DifficultyCell, with model: Difficulty)
}
