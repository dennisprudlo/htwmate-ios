//
//  SettingsAboutController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsAboutController: UITableViewController {

    enum SectionType {
        case version
        case development
    }

    let sections: [(type: SectionType, header: String?, footer: String?)] = [
        (type: .version, header: "Version", footer: nil),
        (type: .development, header: "Development", footer: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Settings.itemAbout
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section].type
        let tableViewCell = UITableViewCell()
        tableViewCell.selectionStyle = .none

        switch sectionType {
        case .version:
            let textLabel = UILabel()
            textLabel.numberOfLines = 0
            textLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .regular)
            textLabel.text = "HTW Mate"
            textLabel.textAlignment = .center
            tableViewCell.contentView.addSubview(textLabel)
            textLabel.pin(to: tableViewCell.contentView, withInset: UIEdgeInsets(top: HWInsets.medium, left: HWInsets.standard, bottom: HWInsets.medium, right: HWInsets.standard))

            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                textLabel.text = """
                    HTW Mate \(version) (\(build))
                """
            }
        case .development:
            let textLabel = UILabel()
            textLabel.numberOfLines = 0
            textLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .regular)
            textLabel.text = "Dennis Prudlo"
            textLabel.textAlignment = .center
            tableViewCell.contentView.addSubview(textLabel)
            textLabel.pin(to: tableViewCell.contentView, withInset: UIEdgeInsets(top: HWInsets.medium, left: HWInsets.standard, bottom: HWInsets.medium, right: HWInsets.standard))
        }

        return tableViewCell
    }
}
