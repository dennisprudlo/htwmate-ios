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
        public static let ratingGreen = UIColor(fromHex: 0x50A225)
        public static let ratingOrange = UIColor(fromHex: 0xE9A000)
        public static let ratingRed = UIColor(fromHex: 0xD60019)
        public static let ratingUndefined = HWColors.StyleGuide.secondaryGray

        public static let badgeVegan = UIColor(fromHex: 0x4F8C00)
        public static let badgeVegetarian = UIColor(fromHex: 0xA8D63D)
        public static let badgeClimateFriendly = UIColor(fromHex: 0x02A9D2)
        public static let badgeSustainable = UIColor(fromHex: 0x00803B)
        public static let badgeSustainableFish = UIColor(fromHex: 0x013D7A)
    }

    // Navigation Layout
    static let darkPrimary = UIColor(fromHex: 0x222222)
    static let darkSecondary = UIColor(fromHex: 0x666666)
    static let darkSecondaryLight = UIColor(fromHex: 0x999999)
    static let darkSecondaryUltraLight = UIColor(fromHex: 0xBBBBBB)

    static let contentBackground = UIColor.white
    static let shadowDrop = UIColor(fromHexRed: 0x33, green: 0x33, blue: 0x33)

    static let skeletonGray = HWColors.contentBackground
}
