//
//  DashboardEventsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardEventsController: UITableViewController {

    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = HWStrings.Controllers.Dashboard.sectionEvents

        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: String(describing: EventTableViewCell.self))

        //
        // Use auto-layout to determine the lecturers cells height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76

        API.shared.eventsResource().get(limit: nil) { (events, response) in
            self.events = events
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventTableViewCell.dequeue(from: tableView)
        cell.setModel(self.events[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        UIApplication.shared.open(self.events[indexPath.row].url, options: [:], completionHandler: nil)
    }

}
