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

        appearance.tintColor = HWColors.whitePrimary
        appearance.barTintColor = HWColors.darkPrimary
    }

}
