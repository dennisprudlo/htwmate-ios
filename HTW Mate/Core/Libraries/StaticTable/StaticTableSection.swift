//
//  SettingsSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StaticTableSection {

    var header: String?
    var footer: String?
    var cells: [StaticTableSectionCell] = []

    var presentingViewController: UIViewController?

    init(header: String?, footer: String?, presentingController presenter: UIViewController? = nil) {
        self.header = header
        self.footer = footer
        self.presentingViewController = presenter
    }

    @discardableResult public func addCell(ofType type: StaticTableSectionCell.CellStyle, title: String, present target: UIViewController) -> StaticTableSectionCell {
        let sectionCell = StaticTableSectionCell(style: type) {
            self.presentingViewController?.navigationController?.pushViewController(target, animated: true)
        }
        sectionCell.setTitle(title)
        self.cells.append(sectionCell)

		return sectionCell
    }

	@discardableResult public func addCell(ofType type: StaticTableSectionCell.CellStyle, title: String, handler: (() -> Void)?) -> StaticTableSectionCell {
        let sectionCell = StaticTableSectionCell(style: type, handler: handler)
        sectionCell.setTitle(title)
        self.cells.append(sectionCell)

		return sectionCell
    }

	@discardableResult func addDefaultCell(ofType type: StaticTableSectionCell.CellStyle, title: String, handler: (() -> Void)?) -> StaticTableSection {
		self.addCell(ofType: type, title: title, handler: handler)
		return self
	}
	
	@discardableResult public func addPushCell(withTitle title: String, present target: UIViewController, needsAuth: Bool = false) -> StaticTableSection {
		let sectionCell = StaticTableSectionCell(style: .disclosure) {
			if needsAuth && !Application.hasAuthenticationInformation() {
				let authController = HWAuthenticationController()
				authController.presenter = self.presentingViewController
				authController.successPushTarget = target
				self.presentingViewController?.present(authController, animated: true, completion: nil)
				return
			}

			self.presentingViewController?.navigationController?.pushViewController(target, animated: true)
		}
		sectionCell.setTitle(title)
		self.cells.append(sectionCell)

		return self
	}

	@discardableResult public func addCustomCell(cell: UITableViewCell, handler: (() -> Void)?) -> StaticTableSection {
        self.cells.append(StaticTableSectionCell(cell: cell, handler: handler))
		return self
    }

	@discardableResult public func addLinkCell(withTitle title: String, opening url: URL?) -> StaticTableSection {
		self.addCell(ofType: .link(icon: HWIcons.link), title: title) {
			guard let unwrappedUrl = url else { return }
			UIApplication.shared.open(unwrappedUrl, options: [:], completionHandler: nil)
		}

		return self
	}

	@discardableResult public func addPDFCell(withTitle title: String, opening url: URL?, subtitle: String? = nil) -> StaticTableSection {
		let type: StaticTableSectionCell.CellStyle = subtitle == nil ? .link(icon: HWIcons.pdf) : .linkSubtitle(icon: HWIcons.pdf)
		let cell = self.addCell(ofType: type, title: title) {
			guard let url = url else {
				return
			}

			let pdfViewController = PDFViewController.make(from: url)
			pdfViewController.getRootView().setTitle(title)
			pdfViewController.getRootView().setPreset(.a4)

			self.presentingViewController?.present(pdfViewController, animated: true, completion: nil)
		}

		if let subtitle = subtitle {
			cell.setDetailTitle(subtitle)
		}

		return self
	}
}
