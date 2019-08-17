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

    public var navigationController: UINavigationController!

    enum SectionType {
        case topNews
        case events
    }
    var sectionType: SectionType = .topNews

    public static let height: CGFloat = 40

    override init(frame: CGRect) {
        super.init(frame: frame)

        let outerInset = HWInsets.medium

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.sectionTitle, weight: .bold)
        addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outerInset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.text = HWStrings.Controllers.Dashboard.metaMore
        detailLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .medium)
        detailLabel.textColor = HWColors.darkSecondaryLight
        detailLabel.isUserInteractionEnabled = true
        addSubview(detailLabel)

        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outerInset).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true

        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailLabel.leadingAnchor, constant: -outerInset).isActive = true

        detailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMore(_:))))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setSection(ofType sectionType: SectionTitleCollectionReusableView.SectionType) {
        self.sectionType = sectionType

        switch sectionType {
        case .topNews:
            titleLabel.text = HWStrings.Controllers.Dashboard.sectionNews
            detailLabel.text = nil
            detailLabel.isUserInteractionEnabled = false
        case .events:
            titleLabel.text = HWStrings.Controllers.Dashboard.sectionEvents
            detailLabel.text = HWStrings.Controllers.Dashboard.metaMore
            detailLabel.isUserInteractionEnabled = true
        }
    }

    public func setTitle(_ title: String) {
        titleLabel.text = title
    }

    public func setDetailTitle(_ title: String) {
        detailLabel.text = nil
    }

    @objc func showMore(_ sender: UITapGestureRecognizer) {
        switch self.sectionType {
        case .topNews:
            print("top news")
        case .events:
            let eventsController = DashboardEventsController(style: .plain)
            guard let presenter = navigationController else { return }
            presenter.pushViewController(eventsController, animated: true)
        }
    }
}
