//
//  UIView+HideKeyboard.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 27..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	/**
	Hides the keyboard if the view is tapped.
	- Parameter onTap: Easy toggle for hiding the keyboard.
					   The default value is true.
	*/
	func shouldHideKeyboard(onTap: Bool = true) {
		let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeybard))
		self.addGestureRecognizer(tap)
	}
	
	/**
	Hides the keyboard if swiped down on the view..
	- Parameter onSwipeDown: Easy toggle for hiding the keyboard.
	The default value is true.
	*/
	func shouldHideKeyboard(onSwipeDown: Bool = true) {
		let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideKeybard))
		swipeDown.direction = .down
		self.addGestureRecognizer(swipeDown)
	}
	
	@objc
	fileprivate func hideKeybard() {
		self.endEditing(true)
	}
}
