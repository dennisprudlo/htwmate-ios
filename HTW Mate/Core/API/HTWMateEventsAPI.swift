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
    ///   - completion: The completion handler after a successful request
    func get(completion: @escaping ([Event], URLResponse) -> Void) {

        let components = API.shared.route(self.endpoint, query: false)
        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var events: [Event] = [Event]()
                    jsonArray.forEach({ (eventItem) in

                        guard let id = eventItem.value(forKey: "id") as? Int else { return }
                        guard let title = eventItem.value(forKey: "title") as? String else { return }
                        guard let subtitle = eventItem.value(forKey: "subtitle") as? String else { return }
                        guard let url = eventItem.value(forKey: "url") as? String else { return }
                        guard let date = eventItem.value(forKey: "date") as? String else { return }

                        guard let event = Event(databaseId: id, title: title, subtitle: subtitle, url: url, date: date) else { return }
                        events.append(event)
                    })
                    completion(events, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
