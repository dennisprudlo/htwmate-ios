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

        let diningController = HWNavigationController(rootViewController: DiningController())
		diningController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Dining.title, image: HWIcons.dining, tag: 3)

		// MARK: Studies Tab

		let studiesController = HWNavigationController(rootViewController: StudiesController(style: .insetGrouped))
		studiesController.tabBarItem = UITabBarItem(title: HWStrings.Controllers.Studies.title, image: HWIcons.studies, tag: 4)

        viewControllers = [
            dashboardController,
            lecturersController,
            diningController,
			studiesController
        ]

		tabBar.barStyle = .black
        tabBar.isTranslucent = true
        tabBar.tintColor = .white
    }
    
}
