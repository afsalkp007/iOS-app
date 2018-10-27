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

    // MARK: - Singleton

    static let shared = SettingsItemProvider()
    class func sharedInstance() -> SettingsItemProvider {
        return self.shared
    }
    private override init() {
        super.init()
    }

    // MARK: - Data provider

    func getSettingsItems() -> [SectionOfCustomData] {
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

		let section1 = SectionOfCustomData(header: "", items: [userInfo, logout])

		var adam = SettingsItem()
		adam.title = "Ádám Berki"
		adam.image = UIImage(named: "youtube")
		adam.url = "https://www.youtube.com/channel/UC87ViraFQBQEMmO--SsQ1cg"

		var levi = SettingsItem()
		levi.title = "@levivig"
		levi.image = UIImage(named: "twitter")
		levi.url = "https://twitter.com/Levivig"

		var pisti = SettingsItem()
		pisti.title = "@Fyccek"
		pisti.image = UIImage(named: "twitter")
		pisti.url = "https://twitter.com/Fyccek"

		let section2 = SectionOfCustomData(header: "Brought to you with ❤️ by:", items: [adam, pisti, levi])

        return [section1, section2]
    }
}
