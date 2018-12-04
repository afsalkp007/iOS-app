//
//  AppDelegate.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var loggedInUser: MyUser? {
		didSet {
			if let user = loggedInUser {
				defaults.set(user.name, forKey: Constants.UserDefaultsKeys.LoggedInUser.name)
				defaults.set(user.email, forKey: Constants.UserDefaultsKeys.LoggedInUser.email)
				defaults.set(user.token, forKey: Constants.UserDefaultsKeys.LoggedInUser.token)
			}
		}
	}

	let defaults = UserDefaults.standard

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}

}
