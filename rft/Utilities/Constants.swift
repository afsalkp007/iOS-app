//
//  Constants.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

	// swiftlint:disable force_cast
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let kBaseURL = "http://levivig.design:8000/api"

    struct Cells {
        static let DifficultyCell = "DifficultyCell"
        static let SettingsCell = "SettingsCell"
        static let TopListCell = "TopListCell"
    }

    struct Notifications {
        static let StartButtonDidTouchUpInside = NSNotification.Name(rawValue: "StartButtonDidTouchUpInside")
		static let FinishedCurrentExecise = NSNotification.Name(rawValue: "FinishedCurrentExecise")
    }

    struct Segues {
        static let LoginToMainScreen = "LoginToMainScreen"
        static let Logout = "Logout"
        static let RegisterToMainScreen = "RegisterToMainScreen"
        static let ShowLogin = "ShowLogin"
        static let ShowMainScreen = "ShowMainScreen"
        static let StartGame = "StartGame"
    }

    struct UserDefaultsKeys {
		struct LoggedInUser {
			static let name = "name"
			static let email = "email"
			static let token = "token"
		}
    }

    struct ViewControllers {
        static let GameNavigationController = "GameNavigationController"
        static let GameViewController = "GameViewController"
        static let LoginNavigationController = "LoginNavigationController"
        static let LoginViewController = "LoginViewController"
        static let MainMenuViewController = "MainMenuViewController"
        static let MainScreenNavigationController = "MainScreenNavigationController"
        static let MainTabbarController = "MainTabbarController"
        static let RegistrationViewController = "RegistrationViewController"
        static let SettingsViewController = "SettingsViewController"
        static let StartViewController = "StartViewController"
        static let TopListNavigationController = "TopListNavigationController"
        static let TopListViewController = "TopListViewController"
    }
}
