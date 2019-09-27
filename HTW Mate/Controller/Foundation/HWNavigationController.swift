//
//  HWNavigationController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/11/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationBar.prefersLargeTitles = true
		navigationBar.tintColor = HWColors.StyleGuide.primaryGreen
		navigationBar.barTintColor = HWColors.contentBackground

		let navBarAppearance = UINavigationBarAppearance()
		navBarAppearance.configureWithOpaqueBackground()
		navBarAppearance.titleTextAttributes = [.foregroundColor: HWColors.primaryText ?? .black]
		navBarAppearance.largeTitleTextAttributes = [.foregroundColor: HWColors.primaryText ?? .black]
		navBarAppearance.backgroundColor = HWColors.contentBackground
		navBarAppearance.shadowColor = HWColors.contentBackground

		navigationBar.standardAppearance = navBarAppearance
		navigationBar.scrollEdgeAppearance = navBarAppearance
	}

}
