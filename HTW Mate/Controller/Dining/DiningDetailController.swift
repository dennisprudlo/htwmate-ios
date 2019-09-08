//
//  DiningDetailController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DiningDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cafeteriaDish: CafeteriaDish! {
        didSet {
            rebuildUI()
        }
    }

    var tableView = UITableView()
    var displayableCells: [UITableViewCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = HWColors.contentBackground

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(CafeteriaDishRatingTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishRatingTableViewCell.self))
        tableView.register(CafeteriaDishInfoMainTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishInfoMainTableViewCell.self))
        tableView.register(CafeteriaDishBadgeTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishBadgeTableViewCell.self))

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    public func rebuildUI() {
        if cafeteriaDish == nil {
            self.displayableCells = []
        } else {
            self.displayableCells = cafeteriaDish.getInfoCells()
        }
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayableCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return displayableCells[indexPath.row]
    }
}
