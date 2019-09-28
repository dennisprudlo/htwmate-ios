//
//  SettingsSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsSection {

    var header: String?
    var footer: String?
    var cells: [SettingsSectionCell] = []

    var presentingViewController: UIViewController?

    init(header: String?, footer: String?, presentingController presenter: UIViewController? = nil) {
        self.header = header
        self.footer = footer
        self.presentingViewController = presenter
    }

    @discardableResult public func addCell(ofType type: SettingsSectionCell.CellStyle, title: String, present target: UIViewController) -> SettingsSectionCell {
        let sectionCell = SettingsSectionCell(style: type) {
            self.presentingViewController?.navigationController?.pushViewController(target, animated: true)
        }
        sectionCell.setTitle(title)

        self.cells.append(sectionCell)
		return sectionCell
    }

	@discardableResult public func addCell(ofType type: SettingsSectionCell.CellStyle, title: String, handler: @escaping () -> Void) -> SettingsSectionCell {
        let sectionCell = SettingsSectionCell(style: type, handler: handler)
        sectionCell.setTitle(title)

        self.cells.append(sectionCell)
		return sectionCell
    }

	@discardableResult public func addLinkCell(withTitle title: String, opening url: URL?) -> SettingsSectionCell {
		return self.addCell(ofType: .link, title: title) {
			guard let unwrappedUrl = url else { return }
			UIApplication.shared.open(unwrappedUrl, options: [:], completionHandler: nil)
		}
	}
}
