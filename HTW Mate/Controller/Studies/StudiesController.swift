//
//  StudiesController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/28/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesController: UITableViewController {

	var sections: [StaticTableSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Studies.title

		configureSections()
    }

	func configureSections() {
		sections.append(StaticTableSection(header: nil, footer: nil, presentingController: self)
			.addPushCell(withTitle: "Grades", present: UIViewController(), needsAuth: true)
		)

		sections.append(StaticTableSection(header: HWStrings.Controllers.Studies.Lectures.title, footer: nil, presentingController: self)
			.addPushCell(withTitle: HWStrings.Controllers.Studies.Lectures.Cancelled.title, present: StudiesLecturesCancelledController(style: .insetGrouped))
		)

		sections.append(StaticTableSection(header: nil, footer: nil, presentingController: self)
			.addPushCell(withTitle: HWStrings.Downloads.title, present: StudiesDownloadsController(style: .insetGrouped))
		)

		sections.append(StaticTableSection(header: HWStrings.Controllers.Studies.HtwServices.title, footer: nil)
			.addLinkCell(withTitle: "LSF",															opening: URL(string: "https://lsf.htw-berlin.de"))
			.addLinkCell(withTitle: "Moodle",														opening: URL(string: "https://moodle.htw-berlin.de/login"))
			.addLinkCell(withTitle: "Webmail",														opening: URL(string: "https://webmail.htw-berlin.de"))
			.addLinkCell(withTitle: HWStrings.Controllers.Studies.HtwServices.universityLibrary,	opening: URL(string: "https://bibliothek.htw-berlin.de"))
			.addLinkCell(withTitle: HWStrings.Controllers.Studies.HtwServices.mediaLibrary,			opening: URL(string: "https://mediathek.htw-berlin.de"))
        )

		sections.append(StaticTableSection(header: nil, footer: nil, presentingController: self)
			.addPushCell(withTitle: HWStrings.Controllers.Settings.title,	present: SettingsController(style: .insetGrouped))
		)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].cells.count
    }

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sections[section].header
	}

	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return sections[section].footer
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return sections[indexPath.section].cells[indexPath.row].tableViewCell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.sections[indexPath.section].cells[indexPath.row].handler?()
    }
}
