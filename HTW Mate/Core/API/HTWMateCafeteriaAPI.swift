//
//  HTWMateCafeteriaAPI.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class HTWMateCafeteriaAPI {

    /// The endpoint for the events resource
    let endpoint = "cafeteria"

    /// Gets all cafeteria dishes
    ///
    /// - Parameters:
    ///   - completion: The completion handler after a successful request
    func get(forDate date: Date, cafeteria: CafeteriaDish.Cafeteria, internationalied: Bool, filter: [String], completion: @escaping ([CafeteriaDish], URLResponse) -> Void) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: date)

        var queryItems = [
			URLQueryItem(name: "date", value: stringDate),
			URLQueryItem(name: "cafeteria", value: cafeteria.rawValue),
			URLQueryItem(name: "internationalized", value: internationalied ? "1" : "0")
		]

		if !filter.isEmpty {
			queryItems.append(URLQueryItem(name: "filter", value: filter.joined(separator: ",")))
		}

		let components = API.shared.route(self.endpoint, queryItems: queryItems)
		
        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var cafeteriaDishes: [CafeteriaDish] = [CafeteriaDish]()
                    jsonArray.forEach({ (dish) in
                        cafeteriaDishes.append(CafeteriaDish.from(json: dish))
                    })
                    completion(cafeteriaDishes, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
