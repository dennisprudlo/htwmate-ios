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
		case disclosureLabel
		case link
    }

    init(style: CellStyle, handler: @escaping () -> Void) {
        self.style = style
        self.handler = handler

        generateTableViewCell()
    }

    func generateTableViewCell() {
        var cell = UITableViewCell(style: .default, reuseIdentifier: nil)

		if self.style == .disclosureLabel {
			cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
		}

        switch self.style {
            case .disclosure:
                cell.accessoryType = .disclosureIndicator
			case .disclosureLabel:
				cell.accessoryType = .disclosureIndicator
			case .link:
				cell.accessoryType = .none
				let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
				imageView.image = HWIcons.link
				imageView.tintColor = HWColors.StyleGuide.primaryGreen
				cell.accessoryView = imageView
        }

        self.tableViewCell = cell
    }

    func setTitle(_ title: String?) {
        self.tableViewCell.textLabel?.text = title
    }

	func setDetailTitle(_ detailTitle: String?) {
		self.tableViewCell.detailTextLabel?.text = detailTitle
	}
}
