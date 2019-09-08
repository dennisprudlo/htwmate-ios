//
//  CafeteriaDishBadgeTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/8/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishBadgeTableViewCell: UITableViewCell {

    var badgeView = UIView()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI() {
        contentView.addSubview(badgeView)
        contentView.addSubview(descriptionLabel)

        let inset = HWInsets.standard
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HWInsets.small).isActive = true
        badgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        badgeView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        badgeView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = HWColors.darkPrimary
        descriptionLabel.font = UIFont.systemFont(ofSize: HWFontSize.text, weight: .regular)
        descriptionLabel.topAnchor.constraint(equalTo: badgeView.topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: HWInsets.medium).isActive = true
        descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset).isActive = true
    }

    func setBadge(_ badge: UIView) {
        badgeView.addSubview(badge)
        badge.topAnchor.constraint(equalTo: badgeView.topAnchor).isActive = true
        badge.leadingAnchor.constraint(equalTo: badgeView.leadingAnchor).isActive = true
        badge.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor).isActive = true
        badge.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor).isActive = true
    }
}
