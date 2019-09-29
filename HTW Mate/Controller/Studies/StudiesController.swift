//
//  StudiesController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/28/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesController: UITableViewController {

	var sections: [SettingsSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Studies.title

		configureSections()
    }

	func configureSections() {
		let lecturesSection = SettingsSection(header: HWStrings.Controllers.Studies.Lectures.title, footer: nil, presentingController: self)
		lecturesSection.addCell(ofType: .disclosureLabel, title: HWStrings.Controllers.Studies.Lectures.Cancelled.title, present: StudiesLecturesCancelledController(style: .insetGrouped))
		sections.append(lecturesSection)

		let htwServicesSection = SettingsSection(header: HWStrings.Controllers.Studies.HtwServices.title, footer: nil)
		htwServicesSection.addLinkCell(withTitle: "LSF", opening: URL(string: "https://lsf.htw-berlin.de"))
		htwServicesSection.addLinkCell(withTitle: "Moodle", opening: URL(string: "https://moodle.htw-berlin.de/login"))
		htwServicesSection.addLinkCell(withTitle: "Webmail", opening: URL(string: "https://webmail.htw-berlin.de"))
		htwServicesSection.addLinkCell(withTitle: HWStrings.Controllers.Studies.HtwServices.universityLibrary, opening: URL(string: "https://bibliothek.htw-berlin.de"))
		htwServicesSection.addLinkCell(withTitle: HWStrings.Controllers.Studies.HtwServices.mediaLibrary, opening: URL(string: "https://mediathek.htw-berlin.de"))
        sections.append(htwServicesSection)
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