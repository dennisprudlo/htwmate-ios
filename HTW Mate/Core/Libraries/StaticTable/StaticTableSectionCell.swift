//
//  SettingsSectionCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StaticTableSectionCell {

    var tableViewCell: UITableViewCell = UITableViewCell()
    var style: CellStyle
    var handler: ((StaticTableSectionCell) -> Void)?
	var icon: UIImage?

    enum CellStyle {
        case disclosure
		case disclosureLabel
		case link(icon: UIImage?)
		case linkSubtitle(icon: UIImage?)
		case destructive
		case nonInteractable
		case nonInteractableDetail
		case custom
    }

    init(style: CellStyle, handler: ((StaticTableSectionCell) -> Void)?) {
        self.style = style
        self.handler = handler

        generateTableViewCell()
    }

	init(cell: UITableViewCell, handler: ((StaticTableSectionCell) -> Void)?) {
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
			case .nonInteractable:
				cell.selectionStyle = .none
			case .nonInteractableDetail:
				cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
				cell.selectionStyle = .none
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
		self.tableViewCell.textLabel?.font = Font.shared.scaled(textStyle: .body)
    }

	func setDetailTitle(_ detailTitle: String?) {
		self.tableViewCell.detailTextLabel?.text = detailTitle
		self.tableViewCell.detailTextLabel?.font = Font.shared.scaled(textStyle: .footnote)
	}
	
	func startLoading() {
		self.icon = (self.tableViewCell.accessoryView as? UIImageView)?.image
		
		let loadingView = UIActivityIndicatorView(style: .medium)
		self.tableViewCell.accessoryView = loadingView
		loadingView.startAnimating()
	}
	
	func stopLoading() {
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
		imageView.image = self.icon
		imageView.tintColor = HWColors.StyleGuide.primaryGreen
		self.tableViewCell.accessoryView = imageView
	}
}
