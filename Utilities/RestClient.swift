//
//  RestClient.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol Networking {
    func getTopList(for difficulty: DifficultyLevel,  with delegate: TopListDelegate)
    func getExercises(for difficulty: DifficultyLevel)
}

class RestClient: NSObject, Networking {
    
    // MARK: Singleton
    static let shared = RestClient()
    
    private override init() {
        super.init()
    }
    
    class func sharedInstance() -> RestClient {
        return self.shared
    }
    
    // MARK: - Login methods
    
    
    // MARK: - TopList methods
    
    /**
     Fetches the users' data for a selected level from the backend service.
     - Parameter difficulty : The difficulty level for loading results
     - Parameter delegate : The delegate which implements the `TopListDelegate` protocol
     */
    func getTopList(for difficulty: DifficultyLevel, with delegate: TopListDelegate) {
        //TODO: Incorporate difficulty into request.
//        let url = "\(Constants.kBaseURL)/topList?level=\(difficulty.rawValue)"
        Alamofire.request("https://www.mocky.io/v2/5bc244243100004e001fca81").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let error = response.error {
                delegate.getTopListDidFail(error: error)
            }
            
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                let jsonData = JSON(json)
                
                var users: [MyUser] = []
                for user in jsonData["users"] {
                    var myUser = MyUser()
                    myUser.name = user.1["name"].rawString()
                    myUser.topScore = user.1["topScore"].rawString()
                    myUser.position = user.1["position"].intValue
                    users.append(myUser)
                }
                delegate.getTopListDidSuccess(users: users)
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    // MARK: - Exercises
    func getExercises(for difficulty: DifficultyLevel) {
        //TODO: Get exercises for appropiate level
//        let url = "\(Constants.kBaseURL)/exercuises?level=\(difficulty.rawValue)"
    }
}
