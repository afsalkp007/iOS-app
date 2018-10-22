//
//  DifficultyProvider.swift
//  rft
//
//  Created by Levente Vig on 2018. 10. 13..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import UIKit

class DifficultyProvider: NSObject {
    
    //MARK: - Singleton
    
    static let shared = DifficultyProvider()
    class func sharedInstance() -> DifficultyProvider {
        return self.shared
    }
    private override init() {
        super.init()
    }
    
    //MARK: - Data provider
    
    func getDifficulties() -> [Difficulty] {
        var beginner = Difficulty()
        beginner.name = "Beginner"
        beginner.image = UIImage(named: "beginner")
		beginner.color = Theme.lightGreen
        
        var intermediate = Difficulty()
        intermediate.name = "Intermediate"
        intermediate.image = UIImage(named: "intermediate")
		intermediate.color = Theme.orange
        
        var advanced = Difficulty()
        advanced.name = "Advanced"
        advanced.image = UIImage(named: "advanced")
		advanced.color = Theme.red
        
        return [beginner, intermediate, advanced]
    }
    
}
