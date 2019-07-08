//
//  SectionTitleCollectionReusableView.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/8/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SectionTitleCollectionReusableView: UICollectionReusableView, Dequeable {

    private var titleLabel = UILabel()
    private var detailLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let outerInset = HWInsets.medium

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outerInset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = NSLocalizedString("more", comment: "The title for the label which shows the user a view with more of the content he sees right now")
        detailLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        detailLabel.textColor = HWColors.darkSecondary
        addSubview(detailLabel)

        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outerInset).isActive = true
        detailLabel.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor).isActive = true

        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailLabel.leadingAnchor, constant: -outerInset).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setTitle(_ title: String) {
        titleLabel.text = title
    }

    public func setDetailTitle(_ title: String) {
        detailLabel.text = title
    }
}
