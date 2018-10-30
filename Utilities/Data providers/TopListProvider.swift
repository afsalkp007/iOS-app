//
//  TopListProvider.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

class TopListProvider {

    var topUsers: [MyUser]?

    // MARK: - Singleton

    static let shared = TopListProvider()
    private init() {}

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
