//
//  AppearanceManager.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation
import UIKit

struct AppearanceManager {

    public static func updateControlsAppearance() -> Void {
        let switchAppearance = UISwitch.appearance()
        switchAppearance.onTintColor = HWColors.StyleGuide.primaryGreen

		let barButtonItems = UIBarButtonItem.appearance(whenContainedInInstancesOf: [HWNavigationController.self])
		barButtonItems.tintColor = HWColors.StyleGuide.primaryGreen

		let greenController = UIBarButtonItem.appearance(whenContainedInInstancesOf: [PDFViewController.self])
		greenController.tintColor = HWColors.contentBackground
		
		let tabBarItemAppearance = UITabBarItem.appearance()
		tabBarItemAppearance.setTitleTextAttributes([
			.font: Font.shared.get(fontSize: .small)
		], for: .normal)
    }
}
