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

    public var onDetailTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        let outerInset = HWInsets.standard

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.sectionTitle, weight: .bold)
        titleLabel.textColor = HWColors.primaryText
        addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outerInset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .medium)
        detailLabel.textColor = HWColors.secondaryText
        detailLabel.isUserInteractionEnabled = false
        addSubview(detailLabel)

        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outerInset).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true

        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailLabel.leadingAnchor, constant: -outerInset).isActive = true

        detailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDetail(_:))))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setTitle(_ title: String?) {
        titleLabel.text = title
    }

    public func setDetailTitle(_ title: String?) {
        detailLabel.text = title
        detailLabel.isUserInteractionEnabled = title != nil
    }

    @objc func didTapDetail(_ sender: UITapGestureRecognizer) {
        onDetailTap?()
    }
}
