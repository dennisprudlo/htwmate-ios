//
//  UITableView+BackgroundView.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/22/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

extension UITableView {

	func setEmptyView(title: String, message: String) {
		let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))

		let titleLabel = UILabel()
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textColor = HWColors.secondaryText
		titleLabel.font = Font.shared.scaled(textStyle: .headline, weight: .bold)
		emptyView.addSubview(titleLabel)
		titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true

		let messageLabel = UILabel()
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		messageLabel.textColor = HWColors.secondaryText
		messageLabel.font = Font.shared.scaled(textStyle: .body, weight: .regular)
		emptyView.addSubview(messageLabel)
		messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: HWInsets.small).isActive = true
		messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: HWInsets.large).isActive = true
		messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -HWInsets.large).isActive = true

		titleLabel.text = title
		messageLabel.text = message
		messageLabel.numberOfLines = 0
		messageLabel.textAlignment = .center

		self.backgroundView = emptyView
		self.separatorStyle = .none
	}

	func restore() {
		self.backgroundView = nil
		self.separatorStyle = .singleLine
	}
}
