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

        // MARK: Dashboard Tab

        let dashboardController = DashboardController(collectionViewLayout: UICollectionViewFlowLayout())
        dashboardController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Dashboard.title, image: HWIcons.dashboard, tag: 1)

        // MARK: Lecturers Tab

        let lecturersController = LecturersController()
        lecturersController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Lecturers.title, image: HWIcons.lecturers, tag: 2)

        let lecturersMasterController = LecturersMasterController()
        lecturersMasterController.title = HWStrings.Controllers.Lecturers.title
        let lecturersMasterNavigationController = HWNavigationController(rootViewController: lecturersMasterController)

        let lecturersDetailNavigationController = HWNavigationController(rootViewController: LecturersDetailController())

        lecturersController.viewControllers = [lecturersMasterNavigationController, lecturersDetailNavigationController]

        // MARK: Dining Tab

        let diningController = DiningController()
        diningController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Dining.title, image: HWIcons.dining, tag: 3)

        let diningMasterController = DiningMasterController()
        diningMasterController.title = HWStrings.Controllers.Dining.title
        let diningMasterNavigationController = HWNavigationController(rootViewController: diningMasterController)

        let diningDetailNavigationController = HWNavigationController(rootViewController: DiningDetailController())

        diningController.viewControllers = [diningMasterNavigationController, diningDetailNavigationController]

        viewControllers = [
            dashboardController,
            lecturersController,
            diningController
        ]
    }
    
}
