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
	var authorizedRequest: Bool = false
	var pdfView = PDFView()
	var pdfData: Data? = nil

	var customTitle: String = "PDF"

	var customAutoScale: Bool			= true
	var customMinScaleFactor: CGFloat	= 0.2
	var customScaleFactor: CGFloat		= 0.4
	var customMaxScaleFactor: CGFloat	= 5
    
    let loader = UIActivityIndicatorView(style: .large)

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
        
        view.addSubview(loader)
        loader.color = .white
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loader.startAnimating()

		DispatchQueue.global(qos: .background).async {
			guard let safeUrl = self.pdfUrl else {
				self.loader.stopAnimating()
				return
			}
			
			if self.authorizedRequest {
				var request = URLRequest(url: safeUrl)
				request.httpMethod = "GET"
				request.setValue(API.shared.token(), forHTTPHeaderField: "HTW-Mate-Authorization")

				let sessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
					guard let data = data else {
						if let error = error {
							print(error.localizedDescription)
						}
						return
					}

					DispatchQueue.main.async {
						self.initFromData(data)
					}
				}
				sessionTask.resume()
			} else {
				guard let data = try? Data(contentsOf: safeUrl) else {
					return
				}
				
				self.pdfData = data
				DispatchQueue.main.async {
					self.initFromData(data)
				}
			}
		}
    }
	
	private func initFromData(_ data: Data) {
		self.pdfView.document		= PDFDocument(data: data)
		self.pdfView.autoScales		= self.customAutoScale
		self.pdfView.minScaleFactor	= self.customMinScaleFactor
		self.pdfView.scaleFactor	= self.customScaleFactor
		self.pdfView.maxScaleFactor	= self.customMaxScaleFactor
		self.pdfView.sizeToFit()
		self.pdfView.layoutDocumentView()
		
		self.navigationItem.rightBarButtonItem?.isEnabled = true
		self.loader.stopAnimating()
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
