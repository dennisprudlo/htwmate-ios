//
//  EventTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell, Dequeable {

    let dateLabel = UILabel()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()

    var event: Event!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.accessoryType = .disclosureIndicator
        self.backgroundColor = HWColors.contentBackground

        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .medium)
        dateLabel.textColor = HWColors.secondaryText
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: HWInsets.medium).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.strongText, weight: .bold)
        titleLabel.textColor = HWColors.primaryText
        titleLabel.numberOfLines = 0
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: HWInsets.extraSmall).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: HWFontSize.text, weight: .regular)
        subtitleLabel.textColor = HWColors.primaryText
        subtitleLabel.numberOfLines = 0
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: HWInsets.extraSmall).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -HWInsets.medium).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setModel(_ event: Event) {
        self.event = event

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateLabel.text = dateFormatter.string(from: event.date)
        titleLabel.text = event.title
        subtitleLabel.text = event.subtitle
    }

}
