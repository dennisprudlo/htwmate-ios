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
    var handler: (() -> Void)?

    enum CellStyle {
        case disclosure
		case disclosureLabel
		case link(icon: UIImage?)
		case linkSubtitle(icon: UIImage?)
		case destructive
		case custom
    }

    init(style: CellStyle, handler: (() -> Void)?) {
        self.style = style
        self.handler = handler

        generateTableViewCell()
    }

	init(cell: UITableViewCell, handler: (() -> Void)?) {
		self.style = .custom
		self.tableViewCell = cell
        self.handler = handler
    }

    func generateTableViewCell() {
        var cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        switch self.style {
            case .disclosure:
                cell.accessoryType = .disclosureIndicator
			case .disclosureLabel:
				cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
				cell.accessoryType = .disclosureIndicator
			case .link(let icon):
				cell.accessoryType = .none
				let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
				imageView.image = icon
				imageView.tintColor = HWColors.StyleGuide.primaryGreen
				cell.accessoryView = imageView
			case .linkSubtitle(let icon):
				cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
				cell.accessoryType = .none
				let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
				imageView.image = icon
				imageView.tintColor = HWColors.StyleGuide.primaryGreen
				cell.accessoryView = imageView
			case .destructive:
				cell.textLabel?.textColor = UIColor.destructiveColor()
			case .custom:
				break
        }

		if handler == nil {
			cell.selectionStyle = .none
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
