//
//  Theme.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 19..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

class Theme: NSObject {
	// MARK: Singleton
	static let shared = Theme()
	
	private override init() {
		super.init()
	}
	
	// MARK: - Colors
	static let darkBlue = UIColor(0x112F41)
	static let lightGreen = UIColor(0x4FB99F)
	static let orange = UIColor(0xF2B134)
	static let red = UIColor(0xED553B)
	static let teal = UIColor(0x068587)
}
