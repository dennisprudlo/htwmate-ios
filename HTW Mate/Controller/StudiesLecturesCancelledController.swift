//
//  StudiesLecturesCancelledController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesLecturesCancelledController: StaticTableViewController {

	var cancelledLecturesSet: [(date: Date, lectures: [LectureCancelled])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = HWStrings.Controllers.Studies.Lectures.Cancelled.title

		API.shared.lecturesResource().getCancelled { (cancelledLecturesSet, response) in
			self.cancelledLecturesSet = []
			cancelledLecturesSet.forEach { (lectureSet) in
				if let first = lectureSet.first {
					self.cancelledLecturesSet.append((date: first.date, lectures: lectureSet))
				}
			}

			self.cancelledLecturesSet.sort { (lectureSetA, lectureSetB) -> Bool in
				return lectureSetA.date.distance(to: lectureSetB.date) > 0
			}

			DispatchQueue.main.async {
				self.configureSections()
			}
		}
    }

	override func configureSections() {
		self.cancelledLecturesSet.forEach { (lecturesSet) in
			var sectionTitle = ""

			let dateFormatter		= DateFormatter()
			dateFormatter.dateStyle	= .full
			sectionTitle			= dateFormatter.string(from: lecturesSet.date)

			let lecturesSection = StaticTableSection(header: sectionTitle, footer: nil)

			lecturesSet.lectures.forEach { (lecture) in
				let lectureCell = StudiesCancelledLectureCell(cancelledLecture: lecture)
				lecturesSection.addCustomCell(cell: lectureCell, handler: nil)
			}

			sections.append(lecturesSection)
		}

		tableView.reloadData()
    }

    // MARK: - Table view data source

	override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
		let lecture = self.cancelledLecturesSet[indexPath.section].lectures[indexPath.row]
		if let comment = lecture.comment {
			AlertManager.init(in: self).with(title: HWStrings.Controllers.Studies.Lectures.Cancelled.comment).with(message: comment).dispatch()
		}
	}
}
