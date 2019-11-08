//
//  HWAuthenticationController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/1/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWAuthenticationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = HWColors.StyleGuide.primaryGreen

		let form = generateFormPanel()

		view.addSubview(form)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.centerYAnchor.constraint(equalTo: form.centerYAnchor).isActive = true
		view.centerXAnchor.constraint(equalTo: form.centerXAnchor).isActive = true
    }

	func generateFormPanel() -> UIView {
		let panel = UIView()
		panel.translatesAutoresizingMaskIntoConstraints = false
		panel.backgroundColor		= HWColors.contentBackground
		panel.layer.cornerRadius	= HWInsets.CornerRadius.panel

		panel.heightAnchor.constraint(equalToConstant: 100).isActive = true
		panel.widthAnchor.constraint(equalToConstant: 250).isActive = true

		return panel
	}
}
