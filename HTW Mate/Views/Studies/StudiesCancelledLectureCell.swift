//
//  StudiesCancelledLectureCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class StudiesCancelledLectureCell: UITableViewCell {

	let cancelledLecture: LectureCancelled

	init(cancelledLecture: LectureCancelled) {
		self.cancelledLecture = cancelledLecture

		super.init(style: .subtitle, reuseIdentifier: nil)

		self.selectionStyle = .none
		setupUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupUI() {
		self.textLabel?.text = cancelledLecture.title
		textLabel?.numberOfLines = 0

		self.detailTextLabel?.text = cancelledLecture.getDetailText()

		if let comment = cancelledLecture.comment {
			self.tintColor = HWColors.StyleGuide.primaryGreen
			self.accessoryType = .detailButton
		}
	}
}
