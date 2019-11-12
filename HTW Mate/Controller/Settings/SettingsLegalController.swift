//
//  SettingsLegalController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsLegalController: UITableViewController {

    var sections: [StaticTableSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = HWStrings.Controllers.Settings.Legal.title

		configureSections()
    }

	func configureSections() {

		let external = StaticTableSection(header: nil, footer: nil)
		external.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.privacyPolicy,	opening: URL(string: "https://htwmate.com/privacy"))
		external.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.masthead,		opening: URL(string: "https://htwmate.com/masthead"))
		external.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.termsOfUse,	opening: URL(string: "https://htwmate.com/terms-of-use"))
		sections.append(external)

		let supportSection = StaticTableSection(header: nil, footer: nil)
		supportSection.addLinkCell(withTitle: HWStrings.Controllers.Settings.Legal.support,	opening: URL(string: "https://htwmate.com/support"))
		sections.append(supportSection)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].cells.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return sections[indexPath.section].cells[indexPath.row].tableViewCell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.sections[indexPath.section].cells[indexPath.row].handler?()
    }
}
