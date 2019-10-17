//
//  CafeteriaDishTitleTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishTitleTableViewCell: UITableViewCell {

    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI() {
        contentView.addSubview(titleLabel)

        let inset = HWInsets.standard
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.textColor = HWColors.primaryText
        titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.enlargedText, weight: .bold)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HWInsets.large).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset).isActive = true
    }
}
