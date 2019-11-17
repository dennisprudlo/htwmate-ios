//
//  Event.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class Event {

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
    ///   - title: The events title
    ///   - subtitle: The events subtitle
    ///   - url: The url to the events info page
    ///   - date: The date of the event
    init(title: String, subtitle: String, url: URL, date: Date) {
        self.title		= title
        self.subtitle	= subtitle
        self.url		= url
        self.date		= date
    }
	
	public static func from(json dictionary: NSDictionary) -> Event? {
		guard
			let title		= dictionary.value(forKey: "title") as? String,
			let subtitle	= dictionary.value(forKey: "subtitle") as? String,
			let urlString	= dictionary.value(forKey: "url") as? String,
			let url			= URL(string: urlString),
			let dateString	= dictionary.value(forKey: "date") as? String
		else {
			return nil
		}
		
		let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
		
		return Event(title: title, subtitle: subtitle, url: url, date: date)
    }
	
	public func dict() -> NSDictionary {
		let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		return [
			"title":		title,
			"subtitle":		subtitle,
			"url":			url.absoluteString,
			"date":			dateFormatter.string(from: date)
		]
	}
}

