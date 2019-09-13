//
//  CafeteriaDishAttributeTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

import UIKit

class CafeteriaDishAttributeTableViewCell: UITableViewCell {

    let badgeView = UIView()
    let symbolLabel = UILabel()
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
        badgeView.addSubview(symbolLabel)
        contentView.addSubview(descriptionLabel)

        let inset = HWInsets.standard
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HWInsets.medium).isActive = true
        badgeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        badgeView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        badgeView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        badgeView.backgroundColor = HWColors.darkPrimary
        badgeView.layer.cornerRadius = HWInsets.CornerRadius.label

        let symbolInset = HWInsets.extraSmall
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.numberOfLines = 1
        symbolLabel.textAlignment = .center
        symbolLabel.textColor = HWColors.contentBackground
        symbolLabel.font = UIFont.systemFont(ofSize: HWFontSize.text, weight: .bold)
        symbolLabel.leadingAnchor.constraint(equalTo: badgeView.leadingAnchor, constant: symbolInset * 2).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: badgeView.topAnchor, constant: symbolInset).isActive = true
        symbolLabel.trailingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: -symbolInset * 2).isActive = true
        symbolLabel.bottomAnchor.constraint(equalTo: badgeView.bottomAnchor, constant: -symbolInset).isActive = true

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = HWColors.darkPrimary
        descriptionLabel.font = UIFont.systemFont(ofSize: HWFontSize.text, weight: .medium)
        descriptionLabel.topAnchor.constraint(equalTo: symbolLabel.topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: badgeView.trailingAnchor, constant: HWInsets.medium).isActive = true
        descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset).isActive = true
    }

    func setDescription(_ description: String?) {
        descriptionLabel.text = description
    }

    func setSymbol(_ symbol: String?) {
        symbolLabel.text = symbol
    }

    func setColor(_ color: UIColor?) {
        badgeView.backgroundColor = color
    }
}
