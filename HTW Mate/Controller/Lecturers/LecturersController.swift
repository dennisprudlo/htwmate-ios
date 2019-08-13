//
//  LecturersController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturersController: UISplitViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = HWStrings.Controllers.Lecturers.title
        extendedLayoutIncludesOpaqueBars = true
    }
    
}
