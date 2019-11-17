//
//  ViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardController: UIViewController, UITableViewDelegate, UITableViewDataSource {
		
	private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
	
    /// The section reference
    private var dashboardSections: [DashboardSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		
        self.configureTableView()

        DashboardNewsStorage.shared.delegate = self
        DashboardNewsStorage.shared.reload()

        DashboardEventStorage.shared.delegate = self
        DashboardEventStorage.shared.reload()

        self.configureSections()
		
		let overlayView = UIView()
		view.addSubview(overlayView)
		overlayView.backgroundColor								= HWColors.contentBackground
		overlayView.translatesAutoresizingMaskIntoConstraints	= false
		overlayView.leadingAnchor.constraint(equalTo:			view.leadingAnchor).isActive = true
		overlayView.trailingAnchor.constraint(equalTo:			view.trailingAnchor).isActive = true
		overlayView.topAnchor.constraint(equalTo:				view.topAnchor).isActive = true
		overlayView.bottomAnchor.constraint(equalTo:			view.safeAreaLayoutGuide.topAnchor).isActive = true
    }

    private func configureTableView() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
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
		tableView.estimatedRowHeight = 150
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
			if DashboardNewsStorage.shared.reloadData || DashboardEventStorage.shared.reloadData {
				tableView.reloadData()
			}
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
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return dashboardSections[section].viewForHeaderInSection()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dashboardSections[section].numberOfItems()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return dashboardSections[indexPath.section].tableViewCell(forItemAt: indexPath)
	}
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return section == dashboardSections.count - 1 ? HWInsets.standard / 2 : HWInsets.standard
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
