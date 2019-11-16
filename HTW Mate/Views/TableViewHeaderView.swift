//
//  TableViewHeaderView.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/16/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class TableViewHeaderView: UIView {
	
	private var titleLabel = UILabel()

	init(title: String) {
		super.init(frame: CGRect.zero)
		
		addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints	= false
		titleLabel.text											= title
		titleLabel.font											= Font.shared.scaled(textStyle: .title3, weight: .black)
        titleLabel.textColor									= HWColors.primaryText
		titleLabel.leadingAnchor.constraint(equalTo:			leadingAnchor, constant: HWInsets.standard).isActive = true
		titleLabel.topAnchor.constraint(equalTo:				topAnchor, constant: HWInsets.extraSmall).isActive = true
		titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -HWInsets.standard).isActive = true
		titleLabel.bottomAnchor.constraint(equalTo:				bottomAnchor, constant: -HWInsets.extraSmall).isActive = true
		
		self.backgroundColor = UIColor(fromHexRed: 240, green: 240, blue: 240)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
}
