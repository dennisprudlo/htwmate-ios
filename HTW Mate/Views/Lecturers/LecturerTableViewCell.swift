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
        lecturerNameLabel.text = "\(lecturer.firstname) \(lecturer.lastname)"
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        //
        // Set the placeholder image
        lecturerImageView.image = HWImage.lecturersProfilePlaceholder

        // TODO: check whether the lecturer has an image url
        guard let url = URL(string: "") else {
            return
        }

        //
        // Download the lecturers image and display it
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                self.lecturerImageView.image = UIImage(data: data)
            }
        }.resume()
    }

}
