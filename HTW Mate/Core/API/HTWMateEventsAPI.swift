//
//  HTWMateEventsAPI.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class HTWMateEventsAPI {

    /// The endpoint for the events resource
    let endpoint = "events"

    /// Gets all events
    ///
    /// - Parameters:
    ///   - limit: The amount of events to fetch. Gets all if nil is passed
    ///   - completion: The completion handler after a successful request
    func get(limit: Int?, completion: @escaping ([Event], URLResponse) -> Void) {
		var queryItems: [URLQueryItem]?
        if let safeLimit = limit {
			queryItems = [URLQueryItem(name: "limit", value: "\(safeLimit)")]
        }
		
        let components = API.shared.route(self.endpoint, queryItems: queryItems)

        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var events: [Event] = [Event]()
                    jsonArray.forEach({ (eventItem) in
						if let event = Event.from(json: eventItem) {
							events.append(event)
						}
                    })
                    completion(events, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
