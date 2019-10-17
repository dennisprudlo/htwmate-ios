//
//  CafeteriaDishTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishTableViewCell: UITableViewCell, Dequeable {

    var ratingView = UIView()
    var titleLabel = UILabel()
    var ingredientsLabel = UILabel()

    var badgesStackView = UIStackView()

    var studentPriceLabel = UILabel()
    var otherPriceLabel = UILabel()

    private var cafeteriaDish: CafeteriaDish!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI() {
        let horizontalSpacing: CGFloat = 20

        contentView.addSubview(ratingView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ingredientsLabel)

        contentView.addSubview(badgesStackView)

        contentView.addSubview(studentPriceLabel)
        contentView.addSubview(otherPriceLabel)

        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.backgroundColor = HWColors.Cafeteria.ratingUndefined
        ratingView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        ratingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.enlargedText, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingView.leadingAnchor, constant: -horizontalSpacing).isActive = true

        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .regular)
        ingredientsLabel.textColor = HWColors.primaryText
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing).isActive = true
        ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        ingredientsLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingView.leadingAnchor, constant: -horizontalSpacing).isActive = true

        badgesStackView.translatesAutoresizingMaskIntoConstraints = false
        badgesStackView.distribution = .equalSpacing
        badgesStackView.spacing = 8
        badgesStackView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 16).isActive = true
        badgesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing).isActive = true
        badgesStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        badgesStackView.backgroundColor = .red

        studentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        studentPriceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: HWFontSize.enlargedText, weight: .bold)
        studentPriceLabel.trailingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: -horizontalSpacing).isActive = true
        studentPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        studentPriceLabel.bottomAnchor.constraint(equalTo: badgesStackView.bottomAnchor).isActive = true

        otherPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        otherPriceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: HWFontSize.metaInfo, weight: .regular)
        otherPriceLabel.textColor = HWColors.primaryText
        otherPriceLabel.trailingAnchor.constraint(equalTo: studentPriceLabel.leadingAnchor, constant: -5).isActive = true
        otherPriceLabel.lastBaselineAnchor.constraint(equalTo: studentPriceLabel.lastBaselineAnchor).isActive = true
        otherPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: badgesStackView.trailingAnchor, constant: 16).isActive = true
    }

    func setModel(_ cafeteriaDish: CafeteriaDish) {
        self.cafeteriaDish = cafeteriaDish

        switch cafeteriaDish.rating {
        case .green:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingGreen
        case .orange:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingOrange
        case .red:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingRed
        case .undefined:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingUndefined
        }

        titleLabel.text = cafeteriaDish.title
        ingredientsLabel.text = cafeteriaDish.getIngredientsNumberChain()

        let priceLabels = cafeteriaDish.getPriceLabels()

        studentPriceLabel.text = priceLabels.student
        otherPriceLabel.text = priceLabels.other
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
