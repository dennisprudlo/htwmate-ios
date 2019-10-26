//
//  StudiesDownloadsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/26/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesDownloadsController: HWSectionableTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Downloads"
    }

	override func configureSections() {
		sections.append(SettingsSection(header: "Academic calendars", footer: nil, presentingController: self)
			.addPDFCell(withTitle: Application.currentSemester().readable(),		opening: API.shared.url("publicapi/downloads/academic-calendar/next"))
			.addPDFCell(withTitle: Application.currentSemester().next().readable(),	opening: API.shared.url("publicapi/downloads/academic-calendar/next"))
		)

		sections.append(SettingsSection(header: "Requests and Forms", footer: nil, presentingController: self)
			.addPDFCell(withTitle: "certificates",				opening: API.shared.url("publicapi/downloads/lsf-requests-forms/certificates/en"))
			.addPDFCell(withTitle: "reimbursement",				opening: API.shared.url("publicapi/downloads/lsf-requests-forms/reimbursement/en"))
			.addPDFCell(withTitle: "leave-of-absence",			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/leave-of-absence/en"))
			.addPDFCell(withTitle: "part-time-studies",			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/part-time-studies/en"))
			.addPDFCell(withTitle: "part-time-studies-revoc",	opening: API.shared.url("publicapi/downloads/lsf-requests-forms/part-time-studies-revoc/en"))
			.addPDFCell(withTitle: "exmatriculation",			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/exmatriculation/en"))
			.addPDFCell(withTitle: "semester-ticket",			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/semester-ticket/en"))
			.addPDFCell(withTitle: "pregnancy-period",			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/pregnancy-period/en"))
		)
    }
}
