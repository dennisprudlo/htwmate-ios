//
//  UIColor+Initalizers.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {


    /// Initializes a UIColor instance with the color parameters given as hexadecimal values
    ///
    /// - Parameters:
    ///   - red: The hexadecimal value of the red component
    ///   - green: The hexadecimal value of the green component
    ///   - blue: The hexadecimal value of the blue component
    ///   - alpha: The hexadecimal value of the alpha component
    public convenience init(fromHexRed red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }

}
