//
//  Event.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class Event : DatabaseModel {

    /// The events title
    var title: String

    /// The events subtitle
    var subtitle: String

    /// The url to the referring info page
    var url: URL

    /// The date of the event
    var date: Date

    /// Initializes an event instance with the given parameters
    ///
    /// - Parameters:
    ///   - id: The id to refer to in the database
    ///   - title: The events title
    ///   - subtitle: The events subtitle
    ///   - url: The url to the events info page
    ///   - date: The date of the event
    init(databaseId id: Int, title: String, subtitle: String, url: URL, date: Date) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
        self.date = date

        super.init(databaseId: id)
    }

    /// Initializes an event instance with the given parameters
    ///
    /// - Parameters:
    ///   - id: The id to refer to in the database
    ///   - title: The events title
    ///   - subtitle: The events subtitle
    ///   - url: The url to the events info page
    ///   - date: The date of the event
    convenience init?(databaseId id: Int, title: String, subtitle: String, url: String, date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let parsedUrl = URL(string: url), let parsedDate = dateFormatter.date(from: date) else {
            return nil
        }

        self.init(databaseId: id, title: title, subtitle: subtitle, url: parsedUrl, date: parsedDate)
    }
}

