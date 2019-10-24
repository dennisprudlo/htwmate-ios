//
//  HWPdfViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/18/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import PDFKit

class PDFRootViewController: UIViewController {

	var pdfUrl: URL?
	var pdfView = PDFView()
	var pdfData: Data? = nil

	var customTitle: String = "PDF"

    override func viewDidLoad() {
        super.viewDidLoad()
		title = customTitle

		view.backgroundColor = HWColors.StyleGuide.primaryGreen

		pdfView.backgroundColor = HWColors.StyleGuide.primaryGreen
		pdfView.displayMode = .singlePageContinuous
		pdfView.pageShadowsEnabled = true

		view.addSubview(pdfView)
		pdfView.translatesAutoresizingMaskIntoConstraints = false
		pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare(_:)))
		navigationItem.rightBarButtonItem?.isEnabled = false

		DispatchQueue.global(qos: .background).async {
			if let safeUrl = self.pdfUrl, let safeDocument = PDFDocument(url: safeUrl) {
				self.pdfData = try? Data(contentsOf: safeUrl)
				DispatchQueue.main.async {
					self.pdfView.document = safeDocument
					self.pdfView.autoScales = true
					self.pdfView.minScaleFactor = 0.2
					self.pdfView.scaleFactor = 0.4
					self.pdfView.maxScaleFactor = 5
					self.pdfView.sizeToFit()
					self.pdfView.layoutDocumentView()

					self.navigationItem.rightBarButtonItem?.isEnabled = true
				}
			}
		}
    }

	func setTitle(_ title: String) {
		customTitle = title
	}

	@objc func didTapShare(_ sender: UIBarButtonItem) {
		if let data = self.pdfData {
			let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
			present(activityViewController, animated: true, completion: nil)
		}
	}
}
