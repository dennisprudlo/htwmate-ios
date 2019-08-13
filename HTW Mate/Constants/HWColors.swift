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
    }

    // Navigation Layout
    static let darkPrimary = UIColor(fromHexRed: 0x22, green: 0x22, blue: 0x22)
    static let darkSecondary = UIColor(fromHexRed: 0x66, green: 0x66, blue: 0x66)
    static let darkSecondaryLight = UIColor(fromHexRed: 0x99, green: 0x99, blue: 0x99)

    static let whitePrimary = UIColor.white
    static let contentBackground = UIColor(fromHexRed: 0xEE, green: 0xEE, blue: 0xEE)
    static let shadowDrop = UIColor(fromHexRed: 0x33, green: 0x33, blue: 0x33)

}
