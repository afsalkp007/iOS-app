//
//  SettingsItemProvider.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

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
		
		var Adam = SettingsItem()
		Adam.title = "Ádám Berki"
		Adam.image = UIImage(named: "youtube")
		Adam.url = "https://www.youtube.com/channel/UC87ViraFQBQEMmO--SsQ1cg"
		
		var Levi = SettingsItem()
		Levi.title = "@levivig"
		Levi.image = UIImage(named: "twitter")
		Levi.url = "https://twitter.com/Levivig"
		
		var Pisti = SettingsItem()
		Pisti.title = "@Fyccek"
		Pisti.image = UIImage(named: "twitter")
		Pisti.url = "https://twitter.com/Fyccek"
        
        return [userInfo, logout, Adam, Levi, Pisti]
    }
    
}
