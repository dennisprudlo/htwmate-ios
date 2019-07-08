//
//  NewsCollectionViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell, Dequeable {

    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        let outerInsets = HWInsets.medium

        contentView.backgroundColor = HWColors.whitePrimary

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)

        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerInsets).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: outerInsets).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerInsets).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .regular)
        subtitleLabel.numberOfLines = 3
        addSubview(subtitleLabel)

        subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerInsets).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -outerInsets).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerInsets).isActive = true
    }

    public func setModel(_ news: News) {
        setTitle(news.title)
        setSubtitle(news.subtitle)

        DownloadManager.image(from: news.imageUrl) { (image) in
            self.setImage(image)
        }
    }

    public func setTitle(_ title: String) {
        titleLabel.text = title
    }

    public func setSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }

    public func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}
