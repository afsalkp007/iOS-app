//
//  AppDelegate.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

	var window: UIWindow?
	var loggedInUser: User? {
		didSet {
			do {
				let encodedData = try NSKeyedArchiver.archivedData(withRootObject: loggedInUser!, requiringSecureCoding: true)
				defaults.set(encodedData, forKey: Constants.UserDefaultsKeys.loggedInUser)
			} catch {
				NSLog("Failed to set defaults key \(Constants.UserDefaultsKeys.loggedInUser)")
			}
		}
	}

	let defaults = UserDefaults.standard

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
		GIDSignIn.sharedInstance().delegate = self

		if isKeyPresentInUserDefaults(key: Constants.UserDefaultsKeys.loggedInUser) {
			if let decoded = defaults.object(forKey: Constants.UserDefaultsKeys.loggedInUser) as? Data {
				do {
					try loggedInUser = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? User
				} catch {
					NSLog("Failed to decode user.")
				}
			}
		}

		Fabric.with([Crashlytics.self, Answers.self])

		return true
	}

	@available(iOS 9.0, *)
	func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
		-> Bool {
			return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
													 annotation: [:])
	}

	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
		// ...
		if let error = error {
			// Login failed
			NSLog("😢 \(error)")
			return
		}

		guard let authentication = user.authentication else { return }
		let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
													   accessToken: authentication.accessToken)
		// Login succesful
		NSLog("👌 \(credential)")
	}

	func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
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
