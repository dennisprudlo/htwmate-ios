//
//  ViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	private let tableView = UITableView()
	
    /// The section reference
    private var dashboardSections: [DashboardSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
		
        self.setStatusBarOverlay()

        DashboardNewsStorage.shared.delegate = self
        DashboardNewsStorage.shared.reload()

        DashboardEventStorage.shared.delegate = self
        DashboardEventStorage.shared.reload()

        self.configureSections()
    }

    private func configureTableView() {
		view.addSubview(tableView)
		tableView.pin(to: view)
		tableView.delegate			= self
		tableView.dataSource		= self
		tableView.separatorStyle	= .none
		tableView.backgroundColor	= HWColors.contentBackground

		//
		// Add refresh control
		tableView.refreshControl	= UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(didRefreshData), for: .valueChanged)
		
		//
		// Use auto-layout to determine the lecturers cells height
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 76
    }

    /// Build the section array for dynamic display of the collection view
    private func configureSections() {
		dashboardSections.append(DashboardNewsSection(presenter: self))
		dashboardSections.append(DashboardEventSection(presenter: self))
    }

    /// Checks whether the collection view shoud reload its data and reload if necessary
    func checkCollectionViewReload() {
        if DashboardNewsStorage.shared.loaded && DashboardEventStorage.shared.loaded {
			tableView.refreshControl?.endRefreshing()
            tableView.reloadData()
        }
    }

    /// Triggered when the user refreshes the collection view using the refresh control
    /// Reloads the data storage
    @objc private func didRefreshData() {
        DashboardNewsStorage.shared.reload()
        DashboardEventStorage.shared.reload()
    }

	func numberOfSections(in tableView: UITableView) -> Int {
		return dashboardSections.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return dashboardSections[section].titleForHeaderInSection()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dashboardSections[section].numberOfItems()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return dashboardSections[indexPath.section].tableViewCell(forItemAt: indexPath)
	}
}
