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
    func route(_ relative: String, query: Bool) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme()
        components.host = self.host()
        components.port = self.port()
        components.path = "/api/\(relative)"

        if query {
            components.queryItems = [URLQueryItem]()
        }

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
}
