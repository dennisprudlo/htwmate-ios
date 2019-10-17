//
//  LecturersMasterController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturersMasterController: UITableViewController, UISearchResultsUpdating, LecturerStorageDelegate {

    let searchController = UISearchController(searchResultsController: nil)

    var searchDelayTimer: Timer?
    var waitForNextLoop = false

    override func viewDidLoad() {
        super.viewDidLoad()

        LecturerStorage.shared.delegate = self

        tableView.register(LecturerTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerTableViewCell.self))

        //
        // Use auto-layout to determine the lecturers cells height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.sectionIndexColor = HWColors.StyleGuide.primaryGreen

        //
        // Prepare search controller
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = HWStrings.Controllers.Lecturers.searchBarTitle
        searchController.searchBar.tintColor = HWColors.StyleGuide.primaryGreen
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
		definesPresentationContext = true

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didRefreshCollectionView(_:)), for: .valueChanged)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //
        // Due to the search controller the shadow image of the navigation bar cannot be removed.
        // So it has to be set hidden on runtime
        if let imageView = navigationItem.searchController?.searchBar.superview?.subviews.first?.subviews.first as? UIImageView {
            imageView.isHidden = true
        }
    }

    // MARK: - Lecturer storage handler

    func lecturerStorage(didReloadLecturers lecturers: [Lecturer]) {
		if LecturerStorage.shared.displayedLecturers.count == 0 {
			self.tableView.setEmptyView(title: HWStrings.Controllers.Lecturers.missingContentTitle, message: HWStrings.Controllers.Lecturers.missingContentSubtitle)
		} else {
			self.tableView.restore()
		}

		tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LecturerStorage.shared.titleForSection(section)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return LecturerStorage.shared.displayedSections
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return LecturerStorage.shared.displayedSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LecturerStorage.shared.lecturers(inSection: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LecturerTableViewCell.dequeue(from: tableView)
        cell.setModel(LecturerStorage.shared.lecturers(inSection: indexPath.section)[indexPath.row])
        cell.lecturerImageView.image = nil
        cell.layoutSubviews()
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

        let lecturers = LecturerStorage.shared.lecturers(inSection: indexPath.section)
        if indexPath.row > lecturers.count {
            return
        }

        let lecturerDetailController = LecturersDetailController()
        lecturerDetailController.lecturer = lecturers[indexPath.row]

        splitViewController?.showDetailViewController(lecturerDetailController, sender: nil)
    }

    @objc private func didRefreshCollectionView(_ sender: Any) {
        LecturerStorage.shared.reload()
    }
}
