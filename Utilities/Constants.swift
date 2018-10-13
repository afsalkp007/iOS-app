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
    
    static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let kBaseURL = "https://rft.com/api/v1"
    
    struct userDefaultsKeys {
        static let loggedInUser = "loggedInUser"
    }
    
    struct segues {
        static let RegisterToMainScreen = "RegisterToMainScreen"
        static let LoginToMainScreen = "LoginToMainScreen"
        static let ShowLogin = "ShowLogin"
        static let ShowMainScreen = "ShowMainScreen"
        static let Logout = "Logout"
        static let StartGame = "StartGame"
    }
    
    struct Cells {
        static let DifficultyCell = "DifficultyCell"
        static let SettingsCell = "SettingsCell"
        static let TopListCell = "TopListCell"
    }
    
    struct Notifications {
        static let StartButtonDidTouchUpInside = NSNotification.Name(rawValue: "StartButtonDidTouchUpInside")
    }
}

enum DifficultyLevel: Int {
    case beginner = 0
    case intermediate = 1
    case advanced = 2
}
