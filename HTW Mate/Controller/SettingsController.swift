//
//  SettingsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsController: StaticTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Settings.title
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.sections = []
		configureSections()
		tableView.reloadData()
	}

	override func configureSections() {
		addSection()
			.addPushCell(withTitle: HWStrings.Controllers.Dining.title, present: SettingsDiningController(style: .insetGrouped))

		addSection()
			.addPushCell(withTitle: HWStrings.Controllers.Settings.itemAbout, present: SettingsAboutController(style: .insetGrouped))
			.addPushCell(withTitle: HWStrings.Controllers.Settings.Legal.title, present: SettingsLegalController(style: .insetGrouped))
		
		if Application.hasAuthenticationInformation() {
			addSection(withHeader: nil, footer: HWStrings.Authentication.unlinkDescription)
				.addDefaultCell(ofType: .destructive, title: HWStrings.Authentication.unlinkTitle) { cell in
					AlertManager.init(in: self).unlinkAccount()
				}
		}
    }
}
