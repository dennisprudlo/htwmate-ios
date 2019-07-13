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
        let appearance = UINavigationBar.appearance()

        appearance.isTranslucent = false
        appearance.tintColor = HWColors.whitePrimary
        appearance.barTintColor = HWColors.darkPrimary

        let textAttributes = [
            NSAttributedString.Key.foregroundColor: HWColors.whitePrimary
        ]
        appearance.titleTextAttributes = textAttributes
        appearance.largeTitleTextAttributes = textAttributes
    }

    /// Updates the global appearance of the tab bar controls
    public static func updateTabBarAppearance() -> Void {
        let appearance = UITabBar.appearance()

        appearance.isTranslucent = false
        appearance.tintColor = HWColors.whitePrimary
        appearance.barTintColor = HWColors.darkPrimary
    }

    public static func dropShadow(for view: UIView) {
        view.backgroundColor = HWColors.whitePrimary
        view.layer.shadowColor = HWColors.shadowDrop.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
    }

}
