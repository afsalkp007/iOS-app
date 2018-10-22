//
//  SettingsCellBinding.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

protocol SettingsCellBinding {
	func bind(to cell: SettingsCell, with model: SettingsItem)
}
