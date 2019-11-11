//
//  Application.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/18/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class Application {

	static let locale = ApplicationLocale()

	static func currentSemester() -> ApplicationSemester {
		let components = Calendar.current.dateComponents([.year, .month], from: Date())

		let year = components.year ?? 0
		let month = components.month ?? 1

		return ApplicationSemester(type: month >= 10 || month < 4 ? .winter : .summer, year: year)
	}
	
	static func hasAuthenticationInformation() -> Bool {
		return getAuthenticationInformation() != nil
	}
	
	static func getAuthenticationInformation() -> (studentId: String, password: String)? {
		guard let studentId = Keychain.standard.string(forKey: Keychain.Key.authenticationStudentId) else {
			return nil
		}
	
		guard let password = Keychain.standard.string(forKey: Keychain.Key.authenticationPassword) else {
			return nil
		}
		
		return (studentId: studentId, password: password)
	}

}
