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
    var detailViewDelegate: LecturersDetailController?

    var searchDelayTimer: Timer?
    var waitForNextLoop = false

    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true

        splitViewController?.delegate = self

        LecturerStorage.shared.delegate = self

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

        if let splitViewController = splitViewController, let detailViewNavigationController = splitViewController.viewControllers.last as? UINavigationController {
            if let detailViewController = detailViewNavigationController.viewControllers.last as? LecturersDetailController {
                detailViewDelegate = detailViewController
            }
        }

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didRefreshCollectionView(_:)), for: .valueChanged)
    }

    // MARK: - Lecturer storage handler

    func lecturerStorage(didReloadLecturers lecturers: [Lecturer]) {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
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
            self.waitForNextLoop = true

            if self.searchDelayTimer == nil {
                self.searchDelayTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(processSearch), userInfo: nil, repeats: true)
            }
        }
    }

    @objc func processSearch() {
        if self.waitForNextLoop {
            self.waitForNextLoop = false
            return
        }

        LecturerStorage.shared.buildDisplayedLecturers(searchText: LecturerStorage.shared.lastSearchText)
        self.searchDelayTimer?.invalidate()
        self.searchDelayTimer = nil
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let detailNavigationController = detailViewDelegate?.navigationController {
            let lecturer = LecturerStorage.shared.lecturers(inSection: indexPath.section)[indexPath.row]
            detailViewDelegate?.lecturer = lecturer
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }

    @objc private func didRefreshCollectionView(_ sender: Any) {
        LecturerStorage.shared.reload()
    }
}
