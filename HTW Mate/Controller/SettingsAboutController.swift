//
//  SettingsAboutController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsAboutController: StaticTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Settings.itemAbout
    }
	
	override func configureSections() {
		
		var versionTitle = "HTW Mate"
		if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
			versionTitle = "HTW Mate \(version)"
		}
		
		var buildTitle = "None"
		if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
			buildTitle = "\(build)"
		}
		
		addSection()
			.addDetailCell(ofType: .nonInteractableDetail, title: versionTitle, detailTitle: HWStrings.General.appVersion)
			.addDetailCell(ofType: .nonInteractableDetail, title: buildTitle, detailTitle: HWStrings.General.buildNumber)
		
		addSection(withHeader: HWStrings.General.development, footer: nil)
			.addDefaultCell(ofType: .nonInteractable, title: "Dennis Prudlo")
	}
}
