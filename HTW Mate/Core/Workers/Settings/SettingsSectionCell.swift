//
//  SettingsSectionCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsSectionCell {

    var tableViewCell: UITableViewCell = UITableViewCell()
    var style: CellStyle
    var handler: () -> Void

    enum CellStyle {
        case disclosure
    }

    init(style: CellStyle, handler: @escaping () -> Void) {
        self.style = style
        self.handler = handler

        generateTableViewCell()
    }

    func generateTableViewCell() {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        switch self.style {
            case .disclosure:
                cell.accessoryType = .disclosureIndicator
        }

        self.tableViewCell = cell
    }

    func setTitle(_ title: String?) {
        self.tableViewCell.textLabel?.text = title
    }
}
