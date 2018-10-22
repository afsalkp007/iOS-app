//
//  SectionedData.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 22..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfCustomData {
	var header: String?
	var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
	typealias Item = BaseModel
	
	init(original: SectionOfCustomData, items: [Item]) {
		self = original
		self.items = items
	}
}
