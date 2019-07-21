//
//  LecturersMasterController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturersMasterController: UITableViewController, UISplitViewControllerDelegate {

    var lecturers: [Lecturer] = [
        Lecturer.from(json: [:]),
        Lecturer.from(json: [:]),
        Lecturer.from(json: [:]),
        Lecturer.from(json: [:])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        splitViewController?.delegate = self

        //
        // Use auto-layout to determine the lecturers cells height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
    }

    // MARK: Split view controller collapse

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lecturers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = LecturerTableViewCell.dequeue(from: tableView)
        cell.setModel(lecturers[indexPath.row])
        return cell
    }

}
