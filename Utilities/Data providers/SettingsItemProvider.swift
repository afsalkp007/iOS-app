//
//  SettingsItemProvider.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

class SettingsItemProvider: NSObject {
    
    //MARK: - Singleton
    
    static let shared = SettingsItemProvider()
    class func sharedInstance() -> SettingsItemProvider {
        return self.shared
    }
    private override init() {
        super.init()
    }
    
    //MARK: - Data provider
    
    func getSettingsItems() -> [SettingsItem] {
        var userInfo = SettingsItem()
        if let name = Constants.kAppDelegate.loggedInUser?.displayName {
            userInfo.title = name
        } else if let email = Constants.kAppDelegate.loggedInUser?.email {
            userInfo.title = email
        } else {
            userInfo.title = "You are not logged in."
        }
        userInfo.image = UIImage(named: "user")
        
        var logout = SettingsItem()
        logout.title = "Logout"
        logout.image = UIImage(named: "logout")
        
        
        return [userInfo, logout]
    }
    
}
