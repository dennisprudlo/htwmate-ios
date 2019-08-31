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

    /// Updates the global appearance of the navigation bar controls
    public static func updateNavigationBarAppearance() -> Void {
        let appearance = UINavigationBar.appearance(whenContainedInInstancesOf: [HWNavigationController.self])

        appearance.barStyle = .default
        appearance.barTintColor = HWColors.whitePrimary
        appearance.tintColor = HWColors.StyleGuide.primaryGreen

        // Remove the bottom shadow from each navigation bar
        appearance.shadowImage = UIImage()
    }

    public static func updateControlsAppearance() -> Void {
        let appearance = UISwitch.appearance()

        appearance.onTintColor = HWColors.StyleGuide.primaryGreen
    }

    /// Updates the global appearance of the tab bar controls
    public static func updateTabBarAppearance() -> Void {
        let appearance = UITabBar.appearance()
        appearance.barStyle = .black
        appearance.tintColor = HWColors.whitePrimary
    }

    public static func dropShadow(for view: UIView, withRadius radius: CGFloat = 10, opacity: Float = 0.5) {
        view.backgroundColor = HWColors.whitePrimary
        view.layer.shadowColor = HWColors.shadowDrop.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }

}
