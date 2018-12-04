//
//  TopListCellBinding.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

protocol TopListCellBinding {
	func bind(to cell: TopListCell, with model: MyUser, index: Int)
}
