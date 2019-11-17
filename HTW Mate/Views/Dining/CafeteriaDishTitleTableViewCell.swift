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
		configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureView() {
        selectionStyle = .none
		
		contentView.addSubview(titleLabel)
		
		titleLabel.translatesAutoresizingMaskIntoConstraints	= false
		
		titleLabel.numberOfLines								= 1
        titleLabel.textColor									= HWColors.primaryText
		titleLabel.font											= Font.shared.scaled(textStyle: .title3, weight: .bold)
		
		titleLabel.leadingAnchor.constraint(equalTo:			contentView.leadingAnchor,	constant: HWInsets.standard).isActive	= true
        titleLabel.topAnchor.constraint(equalTo:				contentView.topAnchor,		constant: HWInsets.large).isActive		= true
		titleLabel.trailingAnchor.constraint(lessThanOrEqualTo:	contentView.trailingAnchor,	constant: -HWInsets.standard).isActive	= true
		titleLabel.bottomAnchor.constraint(lessThanOrEqualTo:	contentView.bottomAnchor,	constant: -HWInsets.small).isActive		= true
	}
}
