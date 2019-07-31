//
//  LecturersMasterController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturersMasterController: UITableViewController, UISplitViewControllerDelegate, UISearchResultsUpdating, LecturerStorageDelegate {

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        splitViewController?.delegate = self

        LecturerStorage.shared.reload(delegate: self)

        //
        // Use auto-layout to determine the lecturers cells height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.sectionIndexColor = HWColors.StyleGuide.primaryGreen

        //
        // Prepare search controller
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search Lecturers", comment: "The placeholder string for the lecturers search bar")
        searchController.searchBar.tintColor = HWColors.StyleGuide.primaryGreen
        searchController.searchBar.barStyle = .blackTranslucent
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }

    // MARK: - Lecturer storage handler

    func lecturerStorage(didReloadLecturers lecturers: [Lecturer]) {
        tableView.reloadData()
    }

    // MARK: - Split view controller collapse

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LecturerStorage.shared.titleForSection(section)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return LecturerStorage.shared.displayedSections
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return LecturerStorage.shared.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LecturerStorage.shared.lecturers(inSection: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LecturerTableViewCell.dequeue(from: tableView)
        cell.setModel(LecturerStorage.shared.lecturers(inSection: indexPath.section)[indexPath.row])
        return cell
    }

    // MARK: - Search bar results updating

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText != LecturerStorage.shared.lastSearchText {
            LecturerStorage.shared.lastSearchText = searchText
            LecturerStorage.shared.buildDisplayedLecturers(delegate: self, searchText: searchText)
        }
    }
}
