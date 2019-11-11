//
//  API.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class API {

    /// The shared API instance
    public static let shared: API = API()

    func newsResource() -> HTWMateNewsAPI {
        return HTWMateNewsAPI()
    }

    func eventsResource() -> HTWMateEventsAPI {
        return HTWMateEventsAPI()
    }

    func lecturersResource() -> HTWMateLecturersAPI {
        return HTWMateLecturersAPI()
    }

    func cafeteriaResource() -> HTWMateCafeteriaAPI {
        return HTWMateCafeteriaAPI()
    }

	func lecturesResource() -> HTWMateLecturesAPI {
        return HTWMateLecturesAPI()
    }
	
	func lsf() -> HTWMateLsfAPI {
		return HTWMateLsfAPI()
	}

    /// Gets the API secret needed to access the HTW Mates API data
    ///
    /// - Returns: The API secret
    func token() -> String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "" }
        guard let token = infoDictionary["HTWMATE_API_TOKEN"] as? String else { return "" }

        return token
    }

    /// Gets the API host scheme
    ///
    /// - Returns: The API host scheme
    func scheme() -> String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "http" }
        guard let scheme = infoDictionary["HTWMATE_API_SCHEME"] as? String else { return "http" }

        return scheme
    }

    /// Gets the API host
    ///
    /// - Returns: The API host
    func host() -> String {
        guard let infoDictionary = Bundle.main.infoDictionary else { return "" }
        guard let host = infoDictionary["HTWMATE_API_HOST"] as? String else { return "" }

        return host
    }

    /// Gets the API port
    ///
    /// - Returns: The API port
    func port() -> Int {
        guard let infoDictionary = Bundle.main.infoDictionary else { return 80 }
        guard let stringPort = infoDictionary["HTWMATE_API_PORT"] as? String else { return 80 }
        guard let port = Int(stringPort) else { return 80 }

        return port
    }

    /// Builds the route for the API request
    ///
    /// - Parameters:
    ///   - relative: The relative endpoint
    ///   - query: Whether to use query parameters or not
    ///   - tokenized: Whether the API request requires the token
    /// - Returns: The URL components used to send the request
    func route(_ relative: String, queryItems: [URLQueryItem]?) -> URLComponents {
        var components = URLComponents()
        components.scheme		= self.scheme()
        components.host			= self.host()
        components.port			= self.port()
        components.path			= "/api/\(relative)"
		components.queryItems	= queryItems

        return components
    }

    /// Performs a general GET request
    ///
    /// - Parameters:
    ///   - route: The URL components object to send the request to
    ///   - completion: The completion handler after a response
    func get(route: URLComponents, completion: @escaping (Data, URLResponse) -> Void) {
        guard let url = route.url else {
            return print("[\(self.self)] Target URL could not be resolved.")
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token(), forHTTPHeaderField: "HTW-Mate-Authorization")

        let sessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response else {
                return print(error?.localizedDescription ?? "[\(self.self)] An error occured in a URL session.")
            }
            completion(data, response)
        }

        sessionTask.resume()
    }

	func post(route: URLComponents, params: [String: String], completion: @escaping (Data, URLResponse) -> Void) {
		guard let url = route.url else {
			return print("[\(self.self)] Target URL could not be resolved.")
		}

		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(token(), forHTTPHeaderField: "HTW-Mate-Authorization")
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

		var postString = ""
		params.forEach { (key, value) in
			postString.append("\(key)=\(value)&")
		}
		postString = String(postString.dropLast())

		request.httpBody = postString.data(using: .utf8)

		let sessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
			guard let data = data, let response = response else {
				if let error = error {
					print(error.localizedDescription)
				}
				return
			}

			completion(data, response)
		}

		sessionTask.resume()
	}

	func url(_ endpoint: String, queryItems: [URLQueryItem]? = nil) -> URL {
		var urlComponents = URLComponents()
		urlComponents.scheme = self.scheme()
		urlComponents.host = self.host()
		urlComponents.port = self.port()
		urlComponents.path = "/\(endpoint)"

		if queryItems != nil {
			urlComponents.queryItems = queryItems
		}

		guard let url = urlComponents.url else {
			return URL(string: "https://htwmate.com")!
		}

		return url.absoluteURL
	}
}
