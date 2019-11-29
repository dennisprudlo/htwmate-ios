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
		if let authInfo = Application.getAuthenticationInformation() {
			let url = API.shared.url("api/schedule/ics", queryItems: [
				URLQueryItem(name: "username", value: authInfo.studentId),
				URLQueryItem(name: "password", value: authInfo.password)
			])
			
			addSection().addDetailCell(ofType: .linkSubtitle(icon: HWIcons.download), title: HWStrings.Downloads.schedule, detailTitle: "iCalendar") { cell in
				cell.startLoading()
				
				URLSession.shared.dataTask(with: url) { (data, response, error) in
					DispatchQueue.main.async {
						cell.stopLoading()
						
						guard let responseUrl = response?.url else {
							return
						}
						
						UIApplication.shared.open(responseUrl, options: [:], completionHandler: nil)
					}
				}.resume()
			}
		}
		
		addSection(withHeader: HWStrings.Downloads.sectionAcademicCalendars)
			.addPDFCell(withTitle: Application.currentSemester().readable(),		opening: API.shared.url("publicapi/downloads/academic-calendar/current"))
			.addPDFCell(withTitle: Application.currentSemester().next().readable(),	opening: API.shared.url("publicapi/downloads/academic-calendar/next"))

		addSection(withHeader: HWStrings.Downloads.sectionRequestsForms)
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
