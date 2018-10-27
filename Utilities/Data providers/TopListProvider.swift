//
//  TopListProvider.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

class TopListProvider: NSObject {

    var topUsers: [MyUser]?

    // MARK: - Singleton

    static let shared = TopListProvider()
    class func sharedInstance() -> TopListProvider {
        return self.shared
    }
    private override init() {
        super.init()
    }

    // MARK: - Data provider

    func getTopUsers() -> [MyUser] {
        if let topUsers = self.topUsers {
            return topUsers
        }
        return []
    }

    func setTopUsers(users: [MyUser]) {
        self.topUsers = users
    }
}
