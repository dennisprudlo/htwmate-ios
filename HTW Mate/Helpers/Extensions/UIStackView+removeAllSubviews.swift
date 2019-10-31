//
//  UIStackView+removeAllSubviews.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/5/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

extension UIStackView {

    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        removedSubviews.forEach({ $0.removeFromSuperview() })
    }

}
