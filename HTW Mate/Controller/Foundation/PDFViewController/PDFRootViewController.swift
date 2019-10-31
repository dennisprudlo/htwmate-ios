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

	var customAutoScale: Bool			= true
	var customMinScaleFactor: CGFloat	= 0.2
	var customScaleFactor: CGFloat		= 0.4
	var customMaxScaleFactor: CGFloat	= 5

	enum PDFViewPreset {
		case a4
	}

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
					self.pdfView.document		= safeDocument
					self.pdfView.autoScales		= self.customAutoScale
					self.pdfView.minScaleFactor	= self.customMinScaleFactor
					self.pdfView.scaleFactor	= self.customScaleFactor
					self.pdfView.maxScaleFactor	= self.customMaxScaleFactor
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

	func setPreset(_ preset: PDFViewPreset) {
		switch preset {
			case .a4:
				self.customScaleFactor = 0.55
		}
	}

	@objc func didTapShare(_ sender: UIBarButtonItem) {
		if let data = self.pdfData {
			let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
			present(activityViewController, animated: true, completion: nil)
		}
	}
}
