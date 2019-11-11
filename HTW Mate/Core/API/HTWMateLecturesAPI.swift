//
//  HTWMateLecturesAPI.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class HTWMateLecturesAPI {

    /// The endpoint for the lectures resource
    let endpoint = "lectures"

    /// Gets all cancelled lectures
    ///
    /// - Parameters:
    ///   - completion: The completion handler after a successful request
    func getCancelled(completion: @escaping ([[LectureCancelled]], URLResponse) -> Void) {
		let components = API.shared.route(self.endpoint + "/cancelled", queryItems: nil)
        API.shared.get(route: components) { (data, response) in
            do {
				if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [NSDictionary]] {
                    var cancelledLectures: [[LectureCancelled]] = [[LectureCancelled]]()
                    jsonArray.forEach({ (dateLectureSet) in
						var dateSet: [LectureCancelled] = []

						dateLectureSet.value.forEach { (lecture) in
							if let cancelled = LectureCancelled.from(json: lecture) {
								dateSet.append(cancelled)
							}
						}

						cancelledLectures.append(dateSet)
                    })
                    completion(cancelledLectures, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
