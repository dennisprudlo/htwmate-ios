//
//  SettingsLegalController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsLegalController: UITableViewController {

    enum SectionType {
        case disclaimer
        case externalLinks
    }

    let sections: [(type: SectionType, header: String?, footer: String?)] = [
        (type: .disclaimer, header: "Disclaimer", footer: nil),
        (type: .externalLinks, header: "External Links Disclaimer", footer: nil)
    ]

    let bearerTitle = "The developer"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Settings.itemLegal
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
        case .disclaimer:
            let textLabel = UILabel()
            textLabel.numberOfLines = 0
            textLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .regular)
            textLabel.text = """
            The information contained in the HTW Mate mobile application (the "Service") is for general information purposes only.

            \(bearerTitle) assumes no responsibility for errors or omissions in the contents of the Service.

            In no event shall the \(bearerTitle.lowercased()) be liable for any special, direct, indirect, consequential, or incidental damages or any damages whatsoever, whether in an action of contract, negligence or other tort, arising out of or in connection with the use of the Service or the contents of the Service. \(bearerTitle) reserves the right to make additions, deletions, or modification to the contents of the Service at any time without prior notice.
            """
            tableViewCell.contentView.addSubview(textLabel)
            textLabel.pin(to: tableViewCell.contentView, withInset: UIEdgeInsets(top: HWInsets.medium, left: HWInsets.standard, bottom: HWInsets.medium, right: HWInsets.standard))
        case .externalLinks:
            let textLabel = UILabel()
            textLabel.numberOfLines = 0
            textLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .regular)
            textLabel.text = """
            HTW Mate mobile application may contain links to external websites that are not provided or maintained by or in any way affiliated with \(bearerTitle.lowercased()).

            Please note that the application does not guarantee the accuracy, relevance, timeliness, or completeness of any information on these external websites.
            """
            tableViewCell.contentView.addSubview(textLabel)
            textLabel.pin(to: tableViewCell.contentView, withInset: UIEdgeInsets(top: HWInsets.medium, left: HWInsets.standard, bottom: HWInsets.medium, right: HWInsets.standard))
        }

        return tableViewCell
    }
}
