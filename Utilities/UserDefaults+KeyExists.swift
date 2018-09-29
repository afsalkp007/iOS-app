//
//  UserDefaults+KeyExists.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}
