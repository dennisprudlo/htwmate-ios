//
//  CafeteriaDishTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishTableViewCell: UITableViewCell, Dequeable {

    private var ratingView			= UIView()
    private var titleLabel			= UILabel()
    private var ingredientsLabel	= UILabel()
    private var badgesStackView 	= UIStackView()
    private var studentPriceLabel	= UILabel()
    private var otherPriceLabel		= UILabel()

	var cafeteriaDish: CafeteriaDish? {
		didSet {
			self.redraw()
		}
	}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
	
	/// Configures the sub-components of the cell. This function should only be called once in an initialization scope because it configures the sub-components constraints
    func configureView() {

		//
		// MARK: Add components to the view
		contentView.addSubview(ratingView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ingredientsLabel)

        contentView.addSubview(badgesStackView)

        contentView.addSubview(studentPriceLabel)
        contentView.addSubview(otherPriceLabel)

		//
		// MARK: Configure to use auto-layouting
		ratingView.translatesAutoresizingMaskIntoConstraints		= false
        titleLabel.translatesAutoresizingMaskIntoConstraints		= false
		ingredientsLabel.translatesAutoresizingMaskIntoConstraints	= false
		badgesStackView.translatesAutoresizingMaskIntoConstraints	= false
        studentPriceLabel.translatesAutoresizingMaskIntoConstraints	= false
		otherPriceLabel.translatesAutoresizingMaskIntoConstraints	= false
		
		//
		// MARK: Configure component styling
        ratingView.backgroundColor		= HWColors.Cafeteria.ratingUndefined
	
		titleLabel.font					= Font.shared.scaled(textStyle: .title3, weight: .bold)
		titleLabel.textColor			= HWColors.primaryText
        titleLabel.numberOfLines		= 0
		
		ingredientsLabel.font			= Font.shared.scaled(textStyle: .footnote, weight: .italic)
        ingredientsLabel.textColor		= HWColors.primaryText
        ingredientsLabel.numberOfLines	= 0
		
		badgesStackView.distribution	= .equalSpacing
        badgesStackView.spacing			= 8
        
		studentPriceLabel.font			= Font.shared.scaled(textStyle: .title3, weight: .bold)
		studentPriceLabel.textColor		= HWColors.primaryText
        
		otherPriceLabel.font			= Font.shared.scaled(textStyle: .footnote, weight: .regular)
        otherPriceLabel.textColor		= HWColors.primaryText
    
		//
		// MARK: Configure component constraints
		ratingView.topAnchor.constraint(equalTo:						contentView.topAnchor).isActive												= true
        ratingView.trailingAnchor.constraint(equalTo:					self.trailingAnchor).isActive												= true
        ratingView.bottomAnchor.constraint(equalTo:						contentView.bottomAnchor).isActive											= true
		ratingView.widthAnchor.constraint(equalToConstant:				HWInsets.decent).isActive													= true

		titleLabel.leadingAnchor.constraint(equalTo:					contentView.leadingAnchor,			constant: HWInsets.standard).isActive	= true
		titleLabel.topAnchor.constraint(equalTo:						contentView.topAnchor,				constant: HWInsets.medium).isActive		= true
		titleLabel.trailingAnchor.constraint(lessThanOrEqualTo:			ratingView.leadingAnchor,			constant: -HWInsets.standard).isActive	= true

		ingredientsLabel.leadingAnchor.constraint(equalTo:				contentView.leadingAnchor,			constant: HWInsets.standard).isActive	= true
		ingredientsLabel.topAnchor.constraint(equalTo:					titleLabel.bottomAnchor,			constant: HWInsets.extraSmall).isActive	= true
		ingredientsLabel.trailingAnchor.constraint(lessThanOrEqualTo:	ratingView.leadingAnchor,			constant: -HWInsets.standard).isActive	= true

		badgesStackView.topAnchor.constraint(equalTo:					ingredientsLabel.bottomAnchor,		constant: HWInsets.medium).isActive		= true
		badgesStackView.leadingAnchor.constraint(equalTo:				contentView.leadingAnchor,			constant: HWInsets.standard).isActive	= true
		badgesStackView.heightAnchor.constraint(equalToConstant:		HWInsets.standard).isActive 												= true

		studentPriceLabel.trailingAnchor.constraint(equalTo:			ratingView.leadingAnchor,			constant: -HWInsets.standard).isActive	= true
		studentPriceLabel.bottomAnchor.constraint(equalTo:				contentView.bottomAnchor,			constant: -HWInsets.medium).isActive	= true
        studentPriceLabel.bottomAnchor.constraint(equalTo:				badgesStackView.bottomAnchor).isActive										= true

        otherPriceLabel.trailingAnchor.constraint(equalTo:				studentPriceLabel.leadingAnchor,	constant: -5).isActive					= true
        otherPriceLabel.lastBaselineAnchor.constraint(equalTo:			studentPriceLabel.lastBaselineAnchor).isActive								= true
		otherPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo:	badgesStackView.trailingAnchor,		constant: HWInsets.medium).isActive		= true
    }
	
    private func redraw() {
        switch cafeteriaDish?.rating {
        case .green:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingGreen
        case .orange:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingOrange
        case .red:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingRed
        case .undefined:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingUndefined
		case nil:
			ratingView.backgroundColor = HWColors.Cafeteria.ratingUndefined
		}

        titleLabel.text			= cafeteriaDish?.title
        ingredientsLabel.text	= cafeteriaDish?.getIngredientsNumberChain()

        let priceLabels			= cafeteriaDish?.getPriceLabels()
        studentPriceLabel.text	= priceLabels?.student
        otherPriceLabel.text	= priceLabels?.other
		
		self.layoutSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        badgesStackView.arrangedSubviews.forEach { (subview) in
            subview.removeFromSuperview()
        }

        guard let dish = cafeteriaDish else { return }

        dish.getBadgeViews().forEach { (badgeData) in
            badgesStackView.addArrangedSubview(badgeData.view)
        }
    }
}
