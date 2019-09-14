//
//  DashboardEventsController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardEventsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {

    let tableView = UITableView(frame: CGRect.zero, style: .plain)

    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = HWStrings.Controllers.Dashboard.sectionEvents

        self.view.backgroundColor = HWColors.contentBackground

        let navigationItem = UINavigationItem()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapClose(_:)))
        navigationItem.title = self.title

        let navigationBar = UINavigationBar()
        self.view.addSubview(navigationBar)
        navigationBar.items = [navigationItem]
        navigationBar.barTintColor = HWColors.contentBackground
        navigationBar.tintColor = HWColors.StyleGuide.primaryGreen
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
        tableView.backgroundColor = HWColors.contentBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: String(describing: EventTableViewCell.self))

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

    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    @objc func didTapClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventTableViewCell.dequeue(from: tableView)
        cell.setModel(self.events[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        UIApplication.shared.open(self.events[indexPath.row].url, options: [:], completionHandler: nil)
    }

}
