//
//  RestClient.swift
//  rft
//
//  Created by Levente Vig on 2018. 09. 29..
//  Copyright © 2018. Levente Vig. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

protocol Networking {
    static func getTopList(for difficulty: DifficultyLevel,  with delegate: TopListDelegate)
	static func getExercises(for difficulty: DifficultyLevel, with delegate: GameDelegate)
}

class RestClient: Networking {

    // MARK: Singleton
    static let shared = RestClient()
    private init() {}

    // MARK: - Login methods

    // MARK: - TopList methods

    /**
     Fetches the users' data for a selected level from the backend service.
     - Parameter difficulty : The difficulty level for loading results
     - Parameter delegate : The delegate which implements the `TopListDelegate` protocol
     */
    static func getTopList(for difficulty: DifficultyLevel, with delegate: TopListDelegate) {
        // TODO: Incorporate difficulty into request.
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
					let myUser = MyUser(json: user.1)
                    users.append(myUser)
                }
                delegate.getTopListDidSuccess(users: users)
            }
        }
    }

    // MARK: - Exercises
	static func getExercises(for difficulty: DifficultyLevel, with delegate: GameDelegate) {
        // TODO: Get exercises for appropiate level
//        let url = "\(Constants.kBaseURL)/exercuises?level=\(difficulty.rawValue)"
		Alamofire.request("https://www.mocky.io/v2/5bc5c9893300006e000213ad").responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result

			if let error = response.error {
				delegate.getExercisesDidFail(with: error)
				return
			}

			if let json = response.result.value {
				print("JSON: \(json)") // serialized json response
				let jsonData = JSON(json)

				var exercises: [Exercise] = []
				for exercise in jsonData["exercises"] {
					let myExercise = Exercise(json: exercise.1)
					exercises.append(myExercise)
				}
				delegate.getExercisesDidSuccess(exercises: exercises)
			}
		}
    }
}
