//
//  StudiesController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/28/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = HWStrings.Controllers.Studies.title
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell(style: .default, reuseIdentifier: "test")
	}

}
