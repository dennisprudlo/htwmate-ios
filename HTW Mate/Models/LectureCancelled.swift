//
//  LectureCancelled.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class LectureCancelled : DatabaseModel {

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

	init(databaseId id: Int, htwLectureId: Int, title: String, group: String, lecturer: String, date: Date, period: (begin: String, end: String), comment: String?) {
		self.htwLectureId = htwLectureId
		self.title = title
		self.group = group
        self.lecturer = lecturer
        self.date = date
        self.period = period
		self.comment = comment

        super.init(databaseId: id)
    }

	public static func from(json dictionary: NSDictionary) -> LectureCancelled? {
        let databaseId		= dictionary.value(forKey: "id") as? Int ?? 0
        let htwLectureId	= dictionary.value(forKey: "htw_lecture_id") as? Int ?? 0
        let title			= dictionary.value(forKey: "title") as? String ?? ""
        let group			= dictionary.value(forKey: "group") as? String ?? ""
		let lecturer		= dictionary.value(forKey: "lecturer") as? String ?? ""
		let date			= dictionary.value(forKey: "date") as? String ?? ""
		let begin			= dictionary.value(forKey: "begin") as? String ?? ""
		let end				= dictionary.value(forKey: "end") as? String ?? ""
		var comment			= dictionary.value(forKey: "comment") as? String

		if comment?.count == 0 {
			comment = nil
		}

		if databaseId == 0 || htwLectureId == 0 {
			return nil
		}

		let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let parsedDate = dateFormatter.date(from: date) else {
            return nil
        }

		let period: (begin: String, end: String) = (begin: begin, end: end)

		return LectureCancelled(databaseId: databaseId, htwLectureId: htwLectureId, title: title, group: group, lecturer: lecturer, date: parsedDate, period: period, comment: comment)
    }

	public func getDetailText() -> String {
		return "\(lecturer) – \(group), \(period.begin) - \(period.end)"
	}
}
