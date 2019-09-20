//
//  SettingController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingController: UITableViewController {

    var sections: [SettingsSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Settings.title

        navigationController?.navigationBar.shadowImage = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissSettings))

        configureSections()
    }

    func configureSections() {
        let categoriesSection = SettingsSection(header: nil, footer: nil, presentingController: self)
        categoriesSection.addCell(ofType: .disclosure, title: HWStrings.Controllers.Dining.title, present: SettingsDiningController(style: .insetGrouped))
        sections.append(categoriesSection)

        let legalSection = SettingsSection(header: nil, footer: nil, presentingController: self)
        legalSection.addCell(ofType: .disclosure, title: HWStrings.Controllers.Settings.itemAbout, present: SettingsAboutController(style: .insetGrouped))
        legalSection.addCell(ofType: .disclosure, title: HWStrings.Controllers.Settings.itemLegal, present: SettingsLegalController(style: .insetGrouped))
        sections.append(legalSection)
    }

    @objc func dismissSettings(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cells.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].header
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.sections[section].footer
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.sections[indexPath.section].cells[indexPath.row].tableViewCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.sections[indexPath.section].cells[indexPath.row].handler()
    }
}
