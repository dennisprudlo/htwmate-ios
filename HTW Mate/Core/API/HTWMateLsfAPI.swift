//
//  HTWMateLsfAPI.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/11/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class HTWMateLsfAPI {

    /// Gets all cancelled lectures
    ///
    /// - Parameters:
    ///   - completion: The completion handler after a successful request
	func auth(username: String, password: String, completion: @escaping (Bool, URLResponse) -> Void) {
        guard let url = URL(string: "https://lsf.htw-berlin.de/qisserver/rds?state=user&type=1") else {
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = "username=\(username)&password=\(password)".data(using: .utf8)
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let response = response else {
				return
			}
			
			guard let responseUrl = response.url else {
				completion(false, response)
				return
			}
			
			if responseUrl.absoluteString == url.absoluteString {
				completion(false, response)
				return
			}
			
			completion(true, response)
		}
		task.resume()
    }
	
	func certificates(completion: @escaping ([String], URLResponse) -> Void) {
		guard let authInfo = Application.getAuthenticationInformation() else {
			return
		}
		
		let components = API.shared.route("certificates", queryItems: [
			URLQueryItem(name: "username", value: authInfo.studentId),
			URLQueryItem(name: "password", value: authInfo.password)
		])
		
		API.shared.get(route: components) { (data, response) in
			do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
					Cache.write(key: .certificates, jsonArray)
					completion(jsonArray, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
	}
}
