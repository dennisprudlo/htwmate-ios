//
//  HWSplitViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/20/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
		self.preferredDisplayMode = .allVisible
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
