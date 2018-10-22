//
//  TopListDelegate.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

/**
 A delegate for interatcing with the toplist.
 */
protocol TopListDelegate: NSObjectProtocol {
    func getTopListDidSuccess(users: [MyUser])
    func getTopListDidFail(error: Error?)
}
