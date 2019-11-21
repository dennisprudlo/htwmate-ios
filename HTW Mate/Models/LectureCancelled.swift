//
//  LectureCancelled.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class LectureCancelled {

	/// The lectures id
    var htwLectureId: Int

    /// The lectures title
    var title: String

    /// The lectures group
    var group: String

    /// The name of the lecturer
    var lecturer: String

	/// The date the lecture should have been
	var date: Date

	/// The time period of the lecture
	var period: (begin: String, end: String)

	/// An additional comment
	var comment: String?

	init(htwLectureId: Int, title: String, group: String, lecturer: String, date: Date, period: (begin: String, end: String), comment: String?) {
		self.htwLectureId = htwLectureId
		self.title = title
		self.group = group
        self.lecturer = lecturer
        self.date = date
        self.period = period
		self.comment = comment
	}

	public static func from(json dictionary: NSDictionary) -> LectureCancelled? {
        guard
			let htwLectureId	= dictionary.value(forKey: "htw_lecture_id") as? Int,
			let title			= dictionary.value(forKey: "title") as? String,
			let group			= dictionary.value(forKey: "group") as? String,
			let lecturer		= dictionary.value(forKey: "lecturer") as? String,
			let dateString		= dictionary.value(forKey: "date") as? String,
			let begin			= dictionary.value(forKey: "begin") as? String,
			let end				= dictionary.value(forKey: "end") as? String
		else {
			return nil
		}
		
		let comment			= dictionary.value(forKey: "comment") as? String
		
		let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }

		let period: (begin: String, end: String) = (begin: begin, end: end)

		return LectureCancelled(htwLectureId: htwLectureId, title: title, group: group, lecturer: lecturer, date: date, period: period, comment: comment)
    }

	public func getDetailText() -> String {
		return "\(lecturer) – \(group), \(period.begin) - \(period.end)"
	}
}
