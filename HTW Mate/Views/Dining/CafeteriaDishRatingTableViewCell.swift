//
//  CafeteriaDishRatingTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/8/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDishRatingTableViewCell: UITableViewCell {

    private let ratingView = UIView()
    private let descriptionLabel = UILabel()

    var rating: CafeteriaDish.Rating = .undefined {
        didSet {
            updateRatingView()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI() {
        contentView.addSubview(ratingView)
        contentView.addSubview(descriptionLabel)

        let inset = HWInsets.standard
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.layer.cornerRadius = HWInsets.CornerRadius.label
        ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HWInsets.small).isActive = true
        ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -HWInsets.small).isActive = true
        ratingView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ratingView.addSubview(descriptionLabel)

        let ratingViewInset = HWInsets.small
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = HWColors.contentBackground
        descriptionLabel.font = UIFont.systemFont(ofSize: HWFontSize.label, weight: .regular)
        descriptionLabel.topAnchor.constraint(equalTo: ratingView.topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: ratingView.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: ratingView.leadingAnchor, constant: ratingViewInset).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: -ratingViewInset).isActive = true
    }

    func updateRatingView() {
        var descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.undefinedLeading
        var descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.undefinedTrailing

        switch rating {
        case .green:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingGreen
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.greenLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.greenTrailing
        case .orange:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingOrange
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.orangeLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.orangeTrailing
        case .red:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingRed
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.redLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.redTrailing
        case .undefined:
            ratingView.backgroundColor = HWColors.Cafeteria.ratingUndefined
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.undefinedLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.undefinedTrailing
        }

        let attributed = NSAttributedString(string: "\(descriptionTextLeading) \(descriptionTextTrailing)")
        let mutable = NSMutableAttributedString(attributedString: attributed)

        let range = NSRange(location: 0, length: descriptionTextLeading.count)
        mutable.addAttribute(.font, value: UIFont.systemFont(ofSize: descriptionLabel.font.pointSize, weight: .bold), range: range)

        descriptionLabel.attributedText = mutable
    }
}
