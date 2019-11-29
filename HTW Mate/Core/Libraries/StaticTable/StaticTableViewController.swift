//
//  StaticTableViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/26/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StaticTableViewController: UITableViewController {

	var sections: [StaticTableSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		configureSections()
    }

	func configureSections() -> Void {

	}
	
	func addSection(withHeader header: String? = nil, footer: String? = nil) -> StaticTableSection {
		let section = StaticTableSection(header: header, footer: footer, presentingController: self)
		self.sections.append(section)
		return section
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return sections[section].cells.count
    }

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sections[section].header
	}

	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		return sections[section].footer
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return sections[indexPath.section].cells[indexPath.row].tableViewCell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let cell = sections[indexPath.section].cells[indexPath.row]
		cell.handler?(cell)
	}
}
