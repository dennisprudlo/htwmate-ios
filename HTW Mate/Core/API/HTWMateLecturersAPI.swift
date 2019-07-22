//
//  HTWMateLecturersAPI.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/22/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class HTWMateLecturersAPI {

    /// The endpoint for the events resource
    let endpoint = "lecturers"

    /// Gets all lecturers
    ///
    /// - Parameters:
    ///   - completion: The completion handler after a successful request
    func get(completion: @escaping ([Lecturer], URLResponse) -> Void) {

        let components = API.shared.route(self.endpoint, query: false)
        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var lecturers: [Lecturer] = [Lecturer]()
                    jsonArray.forEach({ (eventItem) in
                        lecturers.append(Lecturer.from(json: eventItem))
                    })
                    completion(lecturers, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
