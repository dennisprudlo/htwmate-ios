//
//  DashboardEventsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardEventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	let tableView		= UITableView(frame: CGRect.zero, style: .grouped)

    var events: [Event]	= []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = HWStrings.Controllers.Dashboard.sectionEvents

        self.view.backgroundColor = HWColors.contentBackground
		
        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
        tableView.backgroundColor = HWColors.contentBackground
		tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        tableView.register(EventItemTableViewCell.self, forCellReuseIdentifier: String(describing: EventItemTableViewCell.self))

		//
        // Use auto-layout to determine the lecturers cells height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76

        self.reloadEvents()
    }

    public func reloadEvents() {
        self.events = DashboardEventStorage.shared.allEvents
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return DashboardSectionHeaderView(title: HWStrings.Controllers.Dashboard.sectionEvents, detail: nil, detailHandler: {}, paddingTop: HWInsets.standard)
	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventItemTableViewCell.self), for: indexPath) as? EventItemTableViewCell else {
			return UITableViewCell()
		}
		
		cell.setModel(self.events[indexPath.row])
		cell.subtitleLabel.numberOfLines = 0
        return cell
    }

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return HWInsets.standard / 2
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
