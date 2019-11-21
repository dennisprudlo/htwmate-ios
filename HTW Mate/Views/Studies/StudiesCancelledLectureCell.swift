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
		configureView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configureView() {
		selectionStyle = .none
		
		textLabel?.text				= cancelledLecture.title
		textLabel?.font				= Font.shared.scaled(textStyle: .body, weight: .regular)
		textLabel?.numberOfLines	= 0

		detailTextLabel?.text		= cancelledLecture.getDetailText()
		detailTextLabel?.font		= Font.shared.scaled(textStyle: .footnote, weight: .regular)
		
		if let _ = cancelledLecture.comment {
			self.tintColor = HWColors.StyleGuide.primaryGreen
			self.accessoryType = .detailButton
		}
	}
}
