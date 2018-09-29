//
//  RestClient.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation

protocol Networking {
    
}

class RestClient: NSObject, Networking {
    
    // MARK: Singleton
    static let shared = RestClient()
    
    private override init() {
        super.init()
    }
    
    class func sharedInstance() -> RestClient {
        return RestClient.shared
    }
    
    // MARK: Login methods
    
    
    
}
