//
//  LecturerTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturerTableViewCell: UITableViewCell, Dequeable {

    @IBOutlet var lecturerImageView: UIImageView!
    @IBOutlet var lecturerTitleLabel: UILabel!
    @IBOutlet var lecturerNameLabel: UILabel!

    /// The height constraint of the lecturers image view to set the image corner radius properly
    @IBOutlet var lecturerImageViewHeightConstraint: NSLayoutConstraint!

    private var lecturer: Lecturer!

    override func awakeFromNib() {
        super.awakeFromNib()

        //
        // Prepare the lecturer image view
        lecturerImageView.layer.cornerRadius = lecturerImageViewHeightConstraint.constant / 2
        lecturerImageView.clipsToBounds = true
        lecturerImageView.tintColor = UIColor.groupTableViewBackground
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

        if !lecturer.imageSet {
            lecturer.downloadImage { (image) in
                self.lecturerImageView.image = image
            }
        }
    }

}
