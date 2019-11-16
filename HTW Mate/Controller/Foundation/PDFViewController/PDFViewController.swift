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
		navBarAppearance.titleTextAttributes = [
			.foregroundColor: HWColors.contentBackground ?? .white,
			.font: Font.shared.scaled(textStyle: .title3, weight: .bold)
		]
		navBarAppearance.largeTitleTextAttributes = [
			.foregroundColor: HWColors.contentBackground ?? .white,
			.font: Font.shared.scaled(textStyle: .largeTitle, weight: .black)
		]
		navBarAppearance.backgroundColor = HWColors.StyleGuide.primaryGreen.withAlphaComponent(0.9)
		navBarAppearance.shadowColor = nil

		navigationBar.standardAppearance = navBarAppearance
	}

	func getRootView() -> PDFRootViewController {
		guard let pdfRoot = self.viewControllers.first as? PDFRootViewController else {
			return PDFRootViewController()
		}

		return pdfRoot
	}

	static func make(from url: URL?) -> PDFViewController {
		let rootViewController = PDFRootViewController()
		rootViewController.pdfUrl = url

		return PDFViewController(rootViewController: rootViewController)
	}
}
