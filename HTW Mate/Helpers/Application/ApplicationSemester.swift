//
//  ApplicationSemester.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/25/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class ApplicationSemester {

	enum ApplicationSemesterType: String {
		case winter
		case summer
	}

	let type: ApplicationSemesterType
	let year: Int

	init(type: ApplicationSemesterType, year: Int) {
		self.type = type
		self.year = year
	}

	func next() -> ApplicationSemester {
		return ApplicationSemester(type: type == .winter ? .summer : .winter, year: type == .winter ? year + 1 : year)
	}

	func readable() -> String {
		return "\(type == .winter ? HWStrings.University.winterSemester : HWStrings.University.summerSemester) \(year)\(type == .winter ? "/\(year + 1)" : "")"
	}
}
