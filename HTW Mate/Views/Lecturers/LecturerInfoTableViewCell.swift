//
//  LecturerInfoTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/3/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class LecturerInfoTableViewCell: UITableViewCell {

    /// A reference to the table view controller where the cell will be rendered
    var tableViewController: LecturersDetailController!

    let sectionHeadlineLabel = UILabel()

    let cellPadding = HWInsets.medium
    let sectionTitlePadding = HWInsets.small

    var sectionTopAnchor: NSLayoutYAxisAnchor!

    /// Sets up the user interface with the defined layout constraints
    func setupUI(withHeadline headline: String? = nil) -> Void {
        selectionStyle = .none

        sectionTopAnchor = contentView.topAnchor

        if let _ = headline {
            contentView.addSubview(sectionHeadlineLabel)

            sectionHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
            sectionHeadlineLabel.text = headline
            sectionHeadlineLabel.numberOfLines = 1
            sectionHeadlineLabel.font = UIFont.systemFont(ofSize: HWFontSize.enlargedText, weight: .bold)
            sectionHeadlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellPadding).isActive = true
            sectionHeadlineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellPadding).isActive = true
            sectionHeadlineLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -cellPadding).isActive = true

            sectionTopAnchor = sectionHeadlineLabel.bottomAnchor
        }
    }

    /// Reload the data for the controls
    func reload() -> Void {
        
    }

}
