//
//  UIViewController+BlurredStatusBar.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/31/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

extension UIViewController {

    func setStatusBarOverlay() {
        let overlayView = UIView()
        overlayView.backgroundColor = HWColors.contentBackground
        self.view.addSubview(overlayView)

        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        overlayView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

}
