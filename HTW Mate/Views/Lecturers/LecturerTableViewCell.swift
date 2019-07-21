//
//  LecturerTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturerTableViewCell: UITableViewCell, Dequeable {

    override func awakeFromNib() {
        super.awakeFromNib()

//        profileImageView.layer.cornerRadius = profileImageWidthConstraint.constant / 2
//        profileImageView.clipsToBounds = true
//        profileImageView.tintColor = UIColor.groupTableViewBackground
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        // Set placeholder image
//        self.profileImageView.image = nil
//
//        guard let url = self.imageUrl else {
//            return
//        }
//
//        // download image
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data, error == nil else { return }
//
//            DispatchQueue.main.async {
//                self.profileImageView.image = UIImage(data: data)
//            }
//        }.resume()
//    }

}
