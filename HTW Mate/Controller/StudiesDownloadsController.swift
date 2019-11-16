//
//  StudiesDownloadsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/26/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesDownloadsController: StaticTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = HWStrings.Downloads.title
    }

	override func configureSections() {
		addSection(withHeader: HWStrings.Downloads.sectionAcademicCalendars, footer: nil, controller: self)
			.addPDFCell(withTitle: Application.currentSemester().readable(),		opening: API.shared.url("publicapi/downloads/academic-calendar/current"))
			.addPDFCell(withTitle: Application.currentSemester().next().readable(),	opening: API.shared.url("publicapi/downloads/academic-calendar/next"))

		addSection(withHeader: HWStrings.Downloads.sectionRequestsForms, footer: nil, controller: self)
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.certificates,			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/certificates/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.reimbursement,			opening: API.shared.url("publicapi/downloads/lsf-requests-forms/reimbursement/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.leaveOfAbsence,		opening: API.shared.url("publicapi/downloads/lsf-requests-forms/leave-of-absence/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.partTimeStudies,		opening: API.shared.url("publicapi/downloads/lsf-requests-forms/part-time-studies/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.revokePartTimeStudies,	opening: API.shared.url("publicapi/downloads/lsf-requests-forms/part-time-studies-revoc/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.exmatriculation,		opening: API.shared.url("publicapi/downloads/lsf-requests-forms/exmatriculation/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.semesterTicket,		opening: API.shared.url("publicapi/downloads/lsf-requests-forms/semester-ticket/en"))
			.addPDFCell(withTitle: HWStrings.Downloads.Forms.pregnancyPeriod,		opening: API.shared.url("publicapi/downloads/lsf-requests-forms/pregnancy-period/en"))
    }
}
