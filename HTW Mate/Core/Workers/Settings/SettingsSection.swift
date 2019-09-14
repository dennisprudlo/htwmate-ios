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

    public func addCell(ofType type: SettingsSectionCell.CellStyle, title: String, present target: UIViewController) {
        let sectionCell = SettingsSectionCell(style: .disclosure) {
            self.presentingViewController?.navigationController?.pushViewController(target, animated: true)
        }
        sectionCell.setTitle(title)

        self.cells.append(sectionCell)
    }

    public func addCell(ofType type: SettingsSectionCell.CellStyle, title: String, handler: @escaping () -> Void) {
        let sectionCell = SettingsSectionCell(style: .disclosure, handler: handler)
        sectionCell.setTitle(title)

        self.cells.append(sectionCell)
    }
}
