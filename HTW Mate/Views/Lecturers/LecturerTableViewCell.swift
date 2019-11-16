//
//  LecturerTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturerTableViewCell: UITableViewCell, Dequeable {

    var lecturerImageView = UIImageView()
    var lecturerTitleLabel = UILabel()
    var lecturerNameLabel = UILabel()

    private var lecturer: Lecturer!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupUI() {
        contentView.addSubview(lecturerImageView)

        //
        // Prepare the lecturer image view
        let imageHeight: CGFloat = 54
        lecturerImageView.translatesAutoresizingMaskIntoConstraints = false
        lecturerImageView.layer.cornerRadius = imageHeight / 2
        lecturerImageView.clipsToBounds = true
		lecturerImageView.tintColor = HWColors.lecturerPlaceholderTint

		lecturerImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: HWInsets.decent).isActive = true
		lecturerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HWInsets.standard).isActive = true
        lecturerImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -HWInsets.decent).isActive = true
        lecturerImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        lecturerImageView.widthAnchor.constraint(equalTo: lecturerImageView.heightAnchor).isActive = true
		lecturerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        let wrapperView = UIView()
        contentView.addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: HWInsets.decent).isActive = true
		wrapperView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -HWInsets.decent).isActive = true
		wrapperView.leadingAnchor.constraint(equalTo: lecturerImageView.trailingAnchor, constant: HWInsets.medium).isActive = true
        wrapperView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HWInsets.medium).isActive = true

        wrapperView.addSubview(lecturerTitleLabel)
        wrapperView.addSubview(lecturerNameLabel)

        lecturerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		lecturerTitleLabel.font = Font.shared.scaled(textStyle: .footnote, weight: .bold)
        lecturerTitleLabel.textColor = HWColors.darkSecondaryUltraLight

        lecturerTitleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        lecturerTitleLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
        lecturerTitleLabel.bottomAnchor.constraint(equalTo: lecturerNameLabel.topAnchor).isActive = true
        lecturerTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: wrapperView.trailingAnchor).isActive = true

        lecturerNameLabel.translatesAutoresizingMaskIntoConstraints = false
		lecturerNameLabel.font = Font.shared.scaled(textStyle: .body, weight: .bold)
		lecturerNameLabel.numberOfLines = 0
        lecturerNameLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
        lecturerNameLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
        lecturerNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: wrapperView.trailingAnchor).isActive = true
    }

    func setModel(_ lecturer: Lecturer) {
        self.lecturer = lecturer

        lecturerTitleLabel.text = lecturer.title
        lecturerNameLabel.text = lecturer.getFullName()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        //
        // Set the placeholder image
        lecturerImageView.image = lecturer.image
        let lecturerId = lecturer.htwId

        if !lecturer.imageSet {
            lecturer.downloadImage { (image) in
                // Check if the lecturerImageView is still the image view for the lecturer
                // which image was downloaded. It may occur, that this is now another lecturer
                // due to the reusable cells
                if lecturerId == self.lecturer.htwId {
                    self.lecturerImageView.image = image
                }
            }
        }
    }

}
