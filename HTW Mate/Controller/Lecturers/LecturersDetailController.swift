//
//  LecturersDetailController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/31/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturersDetailController: UITableViewController {

    var sectionCells: [LecturerInfoTableViewCell.Type] = []

    var lecturer: Lecturer! {
        didSet {
            rebuildUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        extendedLayoutIncludesOpaqueBars = true

        tableView.register(LecturerInfoHeadTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoHeadTableViewCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }

    func rebuildUI() -> Void {
        self.title = lecturer.lastname

        sectionCells = lecturer.getInfoCellTypes()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: sectionCells[indexPath.row].self)) as? LecturerInfoTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.tableViewController = self
        cell.reload()
        cell.layoutSubviews()
        return cell
    }
}
