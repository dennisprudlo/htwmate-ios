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

    public static func dropShadow(for view: UIView, withRadius radius: CGFloat = 10, opacity: Float = 0.5, ignoreBackground ignore: Bool = false) {
        if !ignore {
            view.backgroundColor = .white
        }
        view.layer.shadowColor = HWColors.shadowDrop?.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize(width: 0, height: radius / 2)
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }

}
