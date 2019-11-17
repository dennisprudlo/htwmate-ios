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
			self.redraw()
        }
    }

    private let tableView							= UITableView()
    private var displayableCells: [UITableViewCell]	= []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
	
	private func configureView() {
		navigationItem.largeTitleDisplayMode	= .never
        view.backgroundColor					= HWColors.contentBackground

		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints			= false
        
        tableView.delegate				= self
        tableView.dataSource			= self
        tableView.separatorStyle		= .none
        tableView.estimatedRowHeight	= 48
        tableView.rowHeight				= UITableView.automaticDimension

        tableView.register(CafeteriaDishInfoMainTableViewCell.self,		forCellReuseIdentifier: String(describing: CafeteriaDishInfoMainTableViewCell.self))
        tableView.register(CafeteriaDishAttributeTableViewCell.self,	forCellReuseIdentifier: String(describing: CafeteriaDishAttributeTableViewCell.self))
        tableView.register(CafeteriaDishTitleTableViewCell.self,		forCellReuseIdentifier: String(describing: CafeteriaDishTitleTableViewCell.self))

        tableView.topAnchor.constraint(equalTo:			self.view.topAnchor).isActive		= true
        tableView.leadingAnchor.constraint(equalTo:		self.view.leadingAnchor).isActive	= true
        tableView.trailingAnchor.constraint(equalTo:	self.view.trailingAnchor).isActive	= true
        tableView.bottomAnchor.constraint(equalTo:		self.view.bottomAnchor).isActive	= true
	}

    private func redraw() {
		displayableCells = []
		
		if let cafeteriaDish = cafeteriaDish {
			displayableCells = cafeteriaDish.getInfoCells()
		}

        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayableCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return displayableCells[indexPath.row]
    }
}
