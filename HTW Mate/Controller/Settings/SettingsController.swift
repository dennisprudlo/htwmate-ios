//
//  SettingsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

	/// Holds all sections to display
    var sections: [SettingsSection] = []

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

	/// Configures the sections for the table view
    func configureSections() {

		//
		// Adds the category section for settings controller
		// Categories can be dining, lecturers, accounts, etc.
        let categoriesSection = SettingsSection(header: nil, footer: nil, presentingController: self)
        categoriesSection.addCell(ofType: .disclosure, title: HWStrings.Controllers.Dining.title, present: SettingsDiningController(style: .insetGrouped))
        sections.append(categoriesSection)

		//
		// Adds the legal section for the settings controller
		// The legal section contains links and information to legal notices
        let legalSection = SettingsSection(header: nil, footer: nil, presentingController: self)
        legalSection.addCell(ofType: .disclosure, title: HWStrings.Controllers.Settings.itemAbout, present: SettingsAboutController(style: .insetGrouped))
		legalSection.addCell(ofType: .disclosure, title: HWStrings.Controllers.Settings.Legal.title, present: SettingsLegalController(style: .insetGrouped))
        sections.append(legalSection)
		
		if Application.hasAuthenticationInformation() {
			sections.append(SettingsSection(header: nil, footer: HWStrings.Authentication.unlinkDescription)
				.addDefaultCell(ofType: .destructive, title: HWStrings.Authentication.unlinkTitle, handler: {
					AlertManager.init(in: self).unlinkAccount()
				})
			)
		}
    }

    // MARK: - Table view data source

	/// Returns the number of sections in the given table view
	/// - Parameter tableView: The table view to get the number of section for
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

	/// Returns the number of rows in a given section
	/// - Parameter tableView: The table view to get the number of rows for
	/// - Parameter section: The section to get the number of rows in
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cells.count
    }

	/// Returns the header title for the given table view section
	/// - Parameter tableView: The table view the title will be placed
	/// - Parameter section: The section to get the title for
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].header
    }

	/// Returns the footer title for the given table view section
	/// - Parameter tableView: The table view where the title will be placed
	/// - Parameter section: The section to get the title for
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.sections[section].footer
    }

	/// Returns the table view cell which should be displayed at the given index path
	/// - Parameter tableView: The table view that will display the cell
	/// - Parameter indexPath: The index path the generated cell will be placed at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.sections[indexPath.section].cells[indexPath.row].tableViewCell
    }

	/// Handles the selection of a table view cell at a given index path
	/// - Parameter tableView: the table view that triggered the selection
	/// - Parameter indexPath: the index path of the selected cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.sections[indexPath.section].cells[indexPath.row].handler?()
    }
}
