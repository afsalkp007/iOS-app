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
		get {
			if isKeyPresentInUserDefaults(key: Constants.UserDefaultsKeys.name) {
				var user = MyUser()
				user.name = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.name)
				user.email = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.email)
				user.token = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.token)
				return user
			}
			return MyUser()
		}
		set {
			if let user = newValue {
				defaults.set(user.name, forKey: Constants.UserDefaultsKeys.name)
				defaults.set(user.email, forKey: Constants.UserDefaultsKeys.email)
				defaults.set(user.token, forKey: Constants.UserDefaultsKeys.token)
				RestClient.updateToken(to: user.token ?? "")
			} else {
				UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.name)
				UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.token)
				UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.email)
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
