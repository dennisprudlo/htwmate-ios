//
//  StudiesCertificatesController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesCertificatesController: StaticTableViewController {

	var certificates: [String] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Certificates"
		
		self.certificates = Cache.read(key: .certificates) ?? []
		self.configureSections()
		
		API.shared.lsf().certificates { (certificates, response) in
			DispatchQueue.main.async {
				self.certificates = certificates
				self.configureSections()
			}
		}
    }

	override func configureSections() {
		sections = []
		
		let section = addSection()
		
		self.certificates.forEach { (certificate) in
			var url: URL? = nil
			
			if let authInfo = Application.getAuthenticationInformation() {
				url = API.shared.url("api/certificates/\(certificate)", queryItems: [
					URLQueryItem(name: "username", value: authInfo.studentId),
					URLQueryItem(name: "password", value: authInfo.password)
				])
			}
			
			section.addPDFCell(withTitle: certificate, opening: url, subtitle: nil, authorize: true)
		}
		
		tableView.reloadData()
    }
}
