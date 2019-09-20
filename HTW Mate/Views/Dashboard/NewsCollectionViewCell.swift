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
    private var blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))

    public var viewController: DashboardController!
    private var news: News!

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        let outerInsets = HWInsets.medium

        AppearanceManager.dropShadow(for: contentView)
        contentView.layer.cornerRadius = HWInsets.CornerRadius.panel

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = HWColors.coverBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = HWInsets.CornerRadius.panel
        addSubview(imageView)

        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        //
        // Add visual effect view
        blurView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(blurView)

        blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .regular)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 3
        imageView.addSubview(subtitleLabel)

        subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: outerInsets).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -outerInsets).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -outerInsets).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        imageView.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: outerInsets).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -HWInsets.extraSmall).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -outerInsets).isActive = true

        blurView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -outerInsets).isActive = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUrl)))
    }

    @objc func openUrl() {
        guard !news.isSkeleton else { return }

        UIApplication.shared.open(news.url, options: [:], completionHandler: nil)
    }

    public func setModel(_ news: News) {
        self.news = news

        setTitle(news.title)
        setSubtitle(news.subtitle)

        blurView.isHidden = news.isSkeleton
        if news.isSkeleton {
            AppearanceManager.dropShadow(for: contentView, withRadius: 4, opacity: 0.1)
        } else {
            AppearanceManager.dropShadow(for: contentView)
        }

        guard news.databaseId != -1 else {
            return
        }
        
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
