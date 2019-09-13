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

    let ratingView = UIView()
    let priceStudentLabel = UILabel()
    let priceOtherLabel = UILabel()

    let pricePointSizeFactor: CGFloat = 1.3
    var paddingConstant: CGFloat = 0

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

        tableView.register(CafeteriaDishInfoMainTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishInfoMainTableViewCell.self))
        tableView.register(CafeteriaDishAttributeTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishAttributeTableViewCell.self))
        tableView.register(CafeteriaDishTitleTableViewCell.self, forCellReuseIdentifier: String(describing: CafeteriaDishTitleTableViewCell.self))

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.view.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: HWInsets.standard).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -HWInsets.standard).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -HWInsets.standard).isActive = true
        ratingView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: HWInsets.standard).isActive = true
        ratingView.layer.cornerRadius = HWInsets.CornerRadius.panel
        AppearanceManager.dropShadow(for: ratingView, withRadius: 5, opacity: 0.3, ignoreBackground: true)

        self.ratingView.addSubview(priceStudentLabel)
        priceStudentLabel.translatesAutoresizingMaskIntoConstraints = false
        priceStudentLabel.numberOfLines = 0
        priceStudentLabel.font = UIFont.monospacedDigitSystemFont(ofSize: HWFontSize.enlargedText * pricePointSizeFactor, weight: .bold)
        priceStudentLabel.textColor = HWColors.contentBackground
        priceStudentLabel.topAnchor.constraint(equalTo: ratingView.topAnchor, constant: HWInsets.medium).isActive = true
        priceStudentLabel.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: -HWInsets.medium).isActive = true
        priceStudentLabel.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -HWInsets.standard).isActive = true

        self.ratingView.addSubview(priceOtherLabel)
        priceOtherLabel.translatesAutoresizingMaskIntoConstraints = false
        priceOtherLabel.numberOfLines = 0
        priceOtherLabel.font = UIFont.monospacedDigitSystemFont(ofSize: HWFontSize.metaInfo * pricePointSizeFactor, weight: .regular)
        priceOtherLabel.textColor = HWColors.contentBackground
        priceOtherLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: HWInsets.standard).isActive = true
        priceOtherLabel.trailingAnchor.constraint(equalTo: priceStudentLabel.leadingAnchor, constant: self.paddingConstant).isActive = true
        priceOtherLabel.lastBaselineAnchor.constraint(equalTo: priceStudentLabel.lastBaselineAnchor).isActive = true
    }

    public func rebuildUI() {
        if cafeteriaDish == nil {
            self.displayableCells = []
            self.tableView.reloadData()
            return
        }

        self.displayableCells = cafeteriaDish.getInfoCells()

        self.ratingView.backgroundColor = cafeteriaDish.getColor()

        let priceLabels = cafeteriaDish.getPriceLabels()
        self.priceStudentLabel.text = priceLabels.student
        self.priceOtherLabel.text = priceLabels.other

        self.paddingConstant = priceLabels.other == nil ? 0 : -5 * self.pricePointSizeFactor

        ratingView.layoutSubviews()

        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayableCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return displayableCells[indexPath.row]
    }
}
