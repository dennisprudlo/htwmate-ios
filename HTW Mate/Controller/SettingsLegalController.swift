//
//  SettingsLegalController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsLegalController: StaticTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = HWStrings.Controllers.Settings.Legal.title
	}

	override func configureSections() {
		addSection()
			.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.privacyPolicy,	opening: URL(string: "https://htwmate.com/privacy"))
			.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.masthead,		opening: URL(string: "https://htwmate.com/masthead"))
			.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.termsOfUse,	opening: URL(string: "https://htwmate.com/terms-of-use"))
		
		addSection()
			.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.support,	opening: URL(string: "https://htwmate.com/support"))
    }
}
