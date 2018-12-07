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
	static func login(with username: String, password: String, with delegate: LoginDelegate)
}

class RestClient: Networking {

    // MARK: Singleton
    static let shared = RestClient()
    private init() {}

	private var headers = [
		"Authorization": "Token \(UserDefaults.standard.value(forKey: Constants.UserDefaultsKeys.token) ?? "")"
	]

	// MARK: - Manage
	static func updateToken(to newToken: String) {
		self.shared.headers["Authorization"] = "Token \(newToken)"
	}

    // MARK: - Login methods
	static func login(with username: String, password: String, with delegate: LoginDelegate) {
		let url = "\(Constants.kBaseURL)/login?username=\(username)&password=\(password)"
		Alamofire.request(url,
						  method: .post,
						  parameters: nil/*params*/,
						  encoding: JSONEncoding.default,
						  headers: nil)
			.validate(statusCode: 200..<300)
			.responseJSON { response in
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result

			switch response.result {
			case .success(let json):
				print("JSON: \(json)") // serialized json response
				let jsonData = JSON(json)

				var loggedInUser = MyUser()
				loggedInUser.name = jsonData["name"].stringValue
				loggedInUser.email = jsonData["email"].stringValue
				loggedInUser.token = jsonData["token"].stringValue

				delegate.loginDidSuccess(response: loggedInUser)
			case .failure(let error):
				delegate.loginDidFail(with: error)
			}
		}
	}

	static func register(with username: String, password: String, email: String, with delegate: LoginDelegate) {
		let url = "\(Constants.kBaseURL)/register?username=\(username)&password=\(password)&email=\(email)"
		Alamofire.request(url,
						  method: .post,
						  parameters: nil/*params*/,
						  encoding: JSONEncoding.default,
						  headers: nil)
			.validate(statusCode: 200..<300)
			.responseJSON { response in
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result

			switch response.result {
			case .success(let json):
				print("JSON: \(json)") // serialized json response
				let jsonData = JSON(json)

				var loggedInUser = MyUser()
				loggedInUser.name = jsonData["name"].stringValue
				loggedInUser.email = jsonData["email"].stringValue
				loggedInUser.token = jsonData["token"].stringValue

				delegate.loginDidSuccess(response: loggedInUser)
			case .failure(let error):
				delegate.loginDidFail(with: error)
			}
		}
	}

    // MARK: - TopList methods

    /**
     Fetches the users' data for a selected level from the backend service.
     - Parameter difficulty : The difficulty level for loading results
     - Parameter delegate : The delegate which implements the `TopListDelegate` protocol
     */
    static func getTopList(for difficulty: DifficultyLevel, with delegate: TopListDelegate) {
        let url = "\(Constants.kBaseURL)/toplist?difficulty=\(difficulty.rawValue)"
		Alamofire.request(url,
						  method: .get,
						  parameters: nil/*params*/,
						  encoding: JSONEncoding.default,
						  headers: shared.headers)
			.validate(statusCode: 200..<300)
			.responseJSON { response in
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
                for user in jsonData {
					let myUser = MyUser(json: user.1)
                    users.append(myUser)
                }
                delegate.getTopListDidSuccess(users: users)
            }
        }
    }

    // MARK: - Exercises
	static func getExercises(for difficulty: DifficultyLevel, with delegate: GameDelegate) {
        let url = "\(Constants.kBaseURL)/tasks?difficulty=\(difficulty.rawValue)"

		Alamofire.request(url,
						  method: .get,
						  parameters: nil,
						  encoding: JSONEncoding.default,
						  headers: shared.headers)
			.validate(statusCode: 200..<300)
			.responseJSON { response in
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
				for exercise in jsonData {
					let myExercise = Exercise(json: exercise.1)
					exercises.append(myExercise)
				}
				delegate.getExercisesDidSuccess(exercises: exercises)
			}
		}
    }

	static func post(_ result: GameResult, for difficulty: DifficultyLevel, with delegate: GameDelegate) {
		var headers = shared.headers
		headers["Content-Type"] = "application/json"
		let url = "\(Constants.kBaseURL)/results?difficulty=\(difficulty.rawValue)"
		let time = result.time
		let correctAnswers = result.correctAnswers
		let params = ["time": time, "correct_answer": correctAnswers] as [String : Any]
		Alamofire.request(url,
						  method: .post,
						  parameters: params,
						  encoding: JSONEncoding.default,
						  headers: shared.headers)
			.validate(statusCode: 200..<300)
			.responseJSON { response in
			print("Request: \(String(describing: response.request))")   // original url request
			print("Response: \(String(describing: response.response))") // http url response
			print("Result: \(response.result)")                         // response serialization result

			if let error = response.error {
				print(error)
				return
			}

			if let json = response.result.value {
				print("JSON: \(json)") // serialized json response
			}
		}
	}
}
