//
//  UIColor+HEX.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 19..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")

		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}

	convenience init(_ hex: UInt, alpha: CGFloat = 1.0) {
		self.init(
			red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(hex & 0x0000FF) / 255.0,
			alpha: alpha
		)
	}
}
