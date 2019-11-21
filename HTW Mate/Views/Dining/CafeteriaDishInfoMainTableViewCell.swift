//
//  CafeteriaDishInfoMainTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishInfoMainTableViewCell: UITableViewCell {

	let ratingView = UIView()
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
		
		contentView.addSubview(ratingView)
        contentView.addSubview(titleLabel)

		ratingView.translatesAutoresizingMaskIntoConstraints	= false
		titleLabel.translatesAutoresizingMaskIntoConstraints	= false
		
		ratingView.backgroundColor								= HWColors.Cafeteria.ratingUndefined
		ratingView.layer.cornerRadius							= HWInsets.CornerRadius.label
		
		titleLabel.font											= Font.shared.scaled(textStyle: .title1, weight: .black)
        titleLabel.textColor									= HWColors.primaryText
        titleLabel.numberOfLines								= 0
        
		ratingView.leadingAnchor.constraint(equalTo:			contentView.trailingAnchor, constant:	-10).isActive	= true
		ratingView.topAnchor.constraint(equalTo:				contentView.topAnchor).isActive							= true
		ratingView.trailingAnchor.constraint(equalTo:			contentView.trailingAnchor, constant:	10).isActive	= true
		ratingView.bottomAnchor.constraint(equalTo:				contentView.bottomAnchor).isActive						= true
		
        titleLabel.bottomAnchor.constraint(equalTo:				contentView.bottomAnchor).isActive										= true
        titleLabel.topAnchor.constraint(equalTo:				contentView.topAnchor, constant:		HWInsets.small).isActive		= true
		titleLabel.leadingAnchor.constraint(equalTo:			contentView.leadingAnchor, constant:	HWInsets.standard).isActive		= true
		titleLabel.trailingAnchor.constraint(lessThanOrEqualTo:	ratingView.leadingAnchor, constant:		-HWInsets.standard).isActive	= true
    }
}
