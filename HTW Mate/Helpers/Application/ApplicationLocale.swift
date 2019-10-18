//
//  ApplicationLocale.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/18/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class ApplicationLocale {

	let original: Locale

	var internationalized: Bool {
		guard let code = self.original.languageCode else {
			return true
		}

		return code != "de"
	}

	init() {
		let preferred = Bundle.main.preferredLocalizations
		if preferred.count > 0, let identifier = preferred.first {
			self.original = Locale(identifier: identifier)
			return
		}

		if let developmentLocalization = Bundle.main.developmentLocalization {
			self.original = Locale(identifier: developmentLocalization)
			return
		}

		self.original = Locale(identifier: "en")
	}
}
