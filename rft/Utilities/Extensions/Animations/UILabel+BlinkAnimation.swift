//
//  UILabel+BlinkAnimation.swift
//  rft
//
//  Created by Levente Vig on 2018. 11. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
	func blink() {
		self.alpha = 0.0
		UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.alpha = 1.0}, completion: nil)
	}
}
