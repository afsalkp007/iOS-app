//
//  SettingsItemProvider.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class SettingsItemProvider {

    // MARK: - Singleton

    static let shared = SettingsItemProvider()
    private init() {}

    // MARK: - Data provider

    func getSettingsItems() -> [SectionOfCustomData] {
        var userInfo = SettingsItem()
        if let name = Constants.kAppDelegate.loggedInUser?.name {
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
		adam.title = "@aberki97"
		adam.image = UIImage(named: "instagram")
		adam.url = "https://www.instagram.com/aberki97/"

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
