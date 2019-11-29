//
//  StudiesController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/28/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesController: StaticTableViewController {

	override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Studies.title
    }

	override func configureSections() {
		addSection()
			.addPushCell(withTitle: "Certificates", present: StudiesCertificatesController(style: .insetGrouped), needsAuth: true)
		
		addSection(withHeader: HWStrings.Controllers.Studies.Lectures.title)
			.addPushCell(withTitle: HWStrings.Controllers.Studies.Lectures.Cancelled.title, present: StudiesLecturesCancelledController(style: .insetGrouped))

		addSection()
			.addPushCell(withTitle: HWStrings.Downloads.title, present: StudiesDownloadsController(style: .insetGrouped))

		addSection(withHeader: HWStrings.Controllers.Studies.HtwServices.title)
			.addLinkCell(withTitle: "LSF",															opening: URL(string: "https://lsf.htw-berlin.de"))
			.addLinkCell(withTitle: "Moodle",														opening: URL(string: "https://moodle.htw-berlin.de/login"))
			.addLinkCell(withTitle: "Webmail",														opening: URL(string: "https://webmail.htw-berlin.de"))
			.addLinkCell(withTitle: HWStrings.Controllers.Studies.HtwServices.universityLibrary,	opening: URL(string: "https://bibliothek.htw-berlin.de"))
			.addLinkCell(withTitle: HWStrings.Controllers.Studies.HtwServices.mediaLibrary,			opening: URL(string: "https://mediathek.htw-berlin.de"))

		addSection()
			.addPushCell(withTitle: HWStrings.Controllers.Settings.title,	present: SettingsController(style: .insetGrouped))
    }
}
