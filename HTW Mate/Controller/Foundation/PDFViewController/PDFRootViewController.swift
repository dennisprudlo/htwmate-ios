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

	public var pdfView = PDFView()
	public var pdfData: Data? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = HWColors.StyleGuide.primaryGreen

		pdfView.backgroundColor = HWColors.StyleGuide.primaryGreen
		pdfView.displayMode = .singlePageContinuous
		pdfView.pageShadowsEnabled = true
		pdfView.autoScales = true
		pdfView.minScaleFactor = 0.2
		pdfView.scaleFactor = 0.4
		pdfView.maxScaleFactor = 5
		pdfView.sizeToFit()
		pdfView.layoutDocumentView()

		view.addSubview(pdfView)
		pdfView.translatesAutoresizingMaskIntoConstraints = false
		pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		pdfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare(_:)))
    }

	@objc func didTapShare(_ sender: UIBarButtonItem) {
		if let data = self.pdfData {
			let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
			present(activityViewController, animated: true, completion: nil)
		}
	}
}
