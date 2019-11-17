//
//  CafeteriaDishAttributeTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishAttributeTableViewCell: UITableViewCell {

    private let badgeView			= UIView()
    private let symbolLabel			= UILabel()
    private let descriptionLabel	= UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureView() {
		selectionStyle = .none
		
        contentView.addSubview(badgeView)
		badgeView.addSubview(symbolLabel)
        contentView.addSubview(descriptionLabel)

		badgeView.translatesAutoresizingMaskIntoConstraints				= false
        symbolLabel.translatesAutoresizingMaskIntoConstraints			= false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints		= false
		
		badgeView.backgroundColor										= HWColors.primaryText
        badgeView.layer.cornerRadius									= HWInsets.CornerRadius.label

		symbolLabel.numberOfLines										= 1
        symbolLabel.textAlignment										= .center
        symbolLabel.textColor											= HWColors.contentBackground
		symbolLabel.font												= Font.shared.scaled(textStyle: .footnote, weight: .bold)
		symbolLabel.adjustsFontForContentSizeCategory					= true

		descriptionLabel.numberOfLines									= 0
        descriptionLabel.textColor										= HWColors.primaryText
		descriptionLabel.font											= Font.shared.scaled(textStyle: .body, weight: .regular)
		descriptionLabel.adjustsFontForContentSizeCategory				= true
        
		badgeView.leadingAnchor.constraint(equalTo:						contentView.leadingAnchor,	constant: HWInsets.standard).isActive		= true
        badgeView.topAnchor.constraint(equalTo:							contentView.topAnchor).isActive											= true
		badgeView.bottomAnchor.constraint(lessThanOrEqualTo:			contentView.bottomAnchor,	constant: -HWInsets.small).isActive			= true
		badgeView.widthAnchor.constraint(equalToConstant:				50).isActive															= true
	
		symbolLabel.leadingAnchor.constraint(equalTo:					badgeView.leadingAnchor,	constant: HWInsets.small).isActive			= true
		symbolLabel.topAnchor.constraint(greaterThanOrEqualTo:			badgeView.topAnchor,		constant: HWInsets.extraSmall).isActive		= true
		symbolLabel.trailingAnchor.constraint(equalTo:					badgeView.trailingAnchor,	constant: -HWInsets.small).isActive			= true
		symbolLabel.bottomAnchor.constraint(lessThanOrEqualTo:			badgeView.bottomAnchor,		constant: -HWInsets.extraSmall).isActive	= true

		descriptionLabel.firstBaselineAnchor.constraint(equalTo:		symbolLabel.firstBaselineAnchor).isActive								= true
		descriptionLabel.leadingAnchor.constraint(equalTo:				badgeView.trailingAnchor,	constant: HWInsets.medium).isActive			= true
		descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo:	contentView.trailingAnchor,	constant: -HWInsets.standard).isActive		= true
		descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo:		contentView.bottomAnchor,	constant: -HWInsets.small).isActive			= true
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
