//
//  LoginDelegate.swift
//  rft
//
//  Created by Levente Vig on 2018. 12. 04..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

protocol LoginDelegate: class {
	func loginDidSuccess(response: MyUser)
	func loginDidFail(with error: Error?)
}
