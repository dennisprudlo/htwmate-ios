//
//  PDFViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/18/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: HWNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationBar.prefersLargeTitles = false
		navigationBar.tintColor = HWColors.contentBackground
		navigationBar.barTintColor = HWColors.StyleGuide.primaryGreen

		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithTransparentBackground()
		navBarAppearance.titleTextAttributes = [.foregroundColor: HWColors.contentBackground ?? .white]
		navBarAppearance.largeTitleTextAttributes = [.foregroundColor: HWColors.contentBackground ?? .white]
		navBarAppearance.backgroundColor = HWColors.StyleGuide.primaryGreen.withAlphaComponent(0.9)
		navBarAppearance.shadowColor = nil

		navigationBar.standardAppearance = navBarAppearance
	}

	static func make(from url: URL?, withTitle title: String = "PDF") -> PDFViewController {
		var document = PDFDocument()
		var pdfData: Data? = nil
		if let safeUrl = url, let safeDocument = PDFDocument(url: safeUrl) {
			document = safeDocument
			pdfData = try? Data(contentsOf: safeUrl)
		}

		let rootViewController = PDFRootViewController()
		rootViewController.title = title
		rootViewController.pdfData = pdfData
		rootViewController.pdfView.document = document

		let controller = PDFViewController(rootViewController: rootViewController)

		return controller
	}
}
