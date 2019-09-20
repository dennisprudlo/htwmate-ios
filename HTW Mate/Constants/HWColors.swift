//
//  Colors.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation
import UIKit

struct HWColors {

    /// Defines the HTW Berlin corporate design colors
    struct StyleGuide {
        public static let primaryGreen = UIColor(fromHex: 0x76B900)
        public static let secondaryBlue = UIColor(fromHex: 0x0082D1)
        public static let secondaryGray = UIColor(fromHex: 0xAFAFAF)
        public static let secondaryOrange = UIColor(fromHex: 0xFF5F00)
    }

    /// Defines the colors used in the canteen menu from the studierendenWERK
    struct Cafeteria {
        public static let ratingGreen = UIColor(named: "dining-rating-green")
        public static let ratingOrange = UIColor(named: "dining-rating-orange")
        public static let ratingRed = UIColor(named: "dining-rating-red")
        public static let ratingUndefined = HWColors.StyleGuide.secondaryGray

        public static let badgeVegan = UIColor(fromHex: 0x4F8C00)
        public static let badgeVegetarian = UIColor(fromHex: 0xA8D63D)
        public static let badgeClimateFriendly = UIColor(fromHex: 0x02A9D2)
        public static let badgeSustainable = UIColor(fromHex: 0x00803B)
        public static let badgeSustainableFish = UIColor(fromHex: 0x013D7A)
    }

    // Navigation Layout
    static let darkSecondaryUltraLight = UIColor(fromHex: 0xBBBBBB)

    static let contentBackground = UIColor(named: "content-background")
    static let coverBackground = UIColor(named: "cover-background")
    static let primaryText = UIColor(named: "primary-text")
    static let secondaryText = UIColor(named: "secondary-text")
    static let shadowDrop = UIColor(named: "shadow-drop")

    static let skeletonGray = HWColors.coverBackground
}
