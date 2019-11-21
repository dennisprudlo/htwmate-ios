//
//  DashboardSectionHeaderView.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/8/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardSectionHeaderView: UIView {

    private var titleLabel = UILabel()
    private var detailLabel = UILabel()

    public var onDetailTap: (() -> Void)?

	init(title: String, detail: String? = nil, detailHandler: @escaping (() -> Void) = {}, paddingTop: CGFloat = 0) {
		super.init(frame: CGRect.zero)
		
		self.onDetailTap = detailHandler

		addSubview(titleLabel)
		addSubview(detailLabel)
		
		titleLabel.translatesAutoresizingMaskIntoConstraints	= false
		titleLabel.font											= Font.shared.get(fontSize: .title, weight: .black)
        titleLabel.textColor									= HWColors.primaryText
		titleLabel.leadingAnchor.constraint(equalTo:			leadingAnchor, constant: HWInsets.standard).isActive = true
		titleLabel.topAnchor.constraint(equalTo:				topAnchor, constant: paddingTop).isActive = true
		titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: detailLabel.leadingAnchor, constant: -HWInsets.standard).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo:				bottomAnchor).isActive = true
		
        detailLabel.translatesAutoresizingMaskIntoConstraints	= false
		detailLabel.font										= Font.shared.get(fontSize: .small, weight: .bold)
        detailLabel.textColor									= HWColors.secondaryText
        detailLabel.isUserInteractionEnabled					= false
		detailLabel.topAnchor.constraint(equalTo:				titleLabel.topAnchor).isActive = true
		detailLabel.trailingAnchor.constraint(equalTo:			trailingAnchor, constant: -HWInsets.standard).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo:			titleLabel.bottomAnchor).isActive = true

        detailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDetail)))
		
		titleLabel.text = title
		detailLabel.text = detail?.lowercased()
		detailLabel.isUserInteractionEnabled = detail != nil
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    @objc func didTapDetail() {
        onDetailTap?()
    }
}
