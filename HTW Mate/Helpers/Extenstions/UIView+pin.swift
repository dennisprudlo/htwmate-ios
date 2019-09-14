//
//  UIView+pin.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

extension UIView {

    public func pin(to target: UIView, withInset inset: UIEdgeInsets = UIEdgeInsets.zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: target.topAnchor, constant: inset.top).isActive = true
        self.bottomAnchor.constraint(equalTo: target.bottomAnchor, constant: -inset.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: target.leadingAnchor, constant: inset.left).isActive = true
        self.trailingAnchor.constraint(equalTo: target.trailingAnchor, constant: -inset.right).isActive = true
    }

}
