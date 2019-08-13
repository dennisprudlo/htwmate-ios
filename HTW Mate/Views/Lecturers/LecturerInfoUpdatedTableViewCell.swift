//
//  LecturerInfoUpdatedTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturerInfoUpdatedTableViewCell : LecturerInfoTableViewCell {

    let updatedAtLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setupUI(withHeadline headline: String? = nil) {
        super.setupUI()

        contentView.addSubview(updatedAtLabel)

        updatedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        updatedAtLabel.numberOfLines = 1
        updatedAtLabel.textAlignment = .center
        updatedAtLabel.textColor = HWColors.darkSecondaryLight
        updatedAtLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .medium)
        updatedAtLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellPadding).isActive = true
        updatedAtLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellPadding).isActive = true
        updatedAtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellPadding).isActive = true
        updatedAtLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellPadding).isActive = true
    }

    override func reload() {
        guard let date = tableViewController.lecturer.lastUpdatedAt else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let lastUpdate = dateFormatter.string(from: date)
        updatedAtLabel.text = "Last update: \(lastUpdate)"
    }

}
