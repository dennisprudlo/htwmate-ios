//
//  LecturerInfoResearchActivitiesTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturerInfoResearchActivitiesTableViewCell : LecturerInfoTableViewCell {

    var genericContentView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setupUI(withHeadline headline: String? = nil) {
        super.setupUI(withHeadline: HWStrings.Controllers.Lecturers.Detail.sectionResearchActivities)

        contentView.addSubview(genericContentView)
        genericContentView.translatesAutoresizingMaskIntoConstraints = false
        genericContentView.topAnchor.constraint(equalTo: super.sectionTopAnchor, constant: super.sectionTitlePadding).isActive = true
        genericContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellPadding).isActive = true
        genericContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellPadding).isActive = true
        genericContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellPadding).isActive = true
    }

    override func reload() {
        let lecturer: Lecturer! = tableViewController.lecturer
        lecturer.researchActivities.render(in: genericContentView)
    }

}
