//
//  HWTabBarController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dashboardController = DashboardController(collectionViewLayout: UICollectionViewFlowLayout())
        dashboardController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Dashboard.title, image: HWIcons.dashboard, tag: 1)

        let lecturersController = LecturersController()
        lecturersController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Lecturers.title, image: HWIcons.lecturers, tag: 2)

        let masterViewController = LecturersMasterController()
        masterViewController.title = HWStrings.Controllers.Lecturers.title
        let detailViewController = LecturersDetailController()

        let masterController = HWNavigationController(rootViewController: masterViewController)
        let detailController = HWNavigationController(rootViewController: detailViewController)

        lecturersController.viewControllers = [masterController, detailController]

        let diningController = DiningController()
        diningController.title = HWStrings.Controllers.Dining.title
        let diningNavigationController = HWNavigationController(rootViewController: diningController)
        diningNavigationController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Dining.title, image: HWIcons.dining, tag: 3)

        viewControllers = [
            dashboardController,
            lecturersController,
            diningNavigationController
        ]
    }
    
}
