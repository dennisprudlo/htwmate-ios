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

        appearance.barStyle = .blackTranslucent
        appearance.tintColor = HWColors.whitePrimary

        let textAttributes = [
            NSAttributedString.Key.foregroundColor: HWColors.whitePrimary
        ]
        appearance.titleTextAttributes = textAttributes
        appearance.largeTitleTextAttributes = textAttributes
    }

    /// Updates the global appearance of the tab bar controls
    public static func updateTabBarAppearance() -> Void {
        let appearance = UITabBar.appearance()
        appearance.barStyle = .black
        appearance.tintColor = HWColors.whitePrimary
    }

    public static func dropShadow(for view: UIView, withRadius radius: CGFloat = 10, opacity: Float = 0.3) {
        view.backgroundColor = HWColors.whitePrimary
        view.layer.shadowColor = HWColors.shadowDrop.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }

}
