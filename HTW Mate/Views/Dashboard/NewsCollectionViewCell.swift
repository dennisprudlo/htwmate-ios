//
//  NewsCollectionViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import SafariServices

class NewsCollectionViewCell: UICollectionViewCell, Dequeable, SFSafariViewControllerDelegate {

    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var imageView = UIImageView()

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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = HWInsets.CornerRadius.panel
        addSubview(imageView)

        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        //
        // Add visual effect view
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(blurView)

        blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .regular)
        subtitleLabel.textColor = HWColors.whitePrimary
        subtitleLabel.numberOfLines = 3
        imageView.addSubview(subtitleLabel)

        subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: outerInsets).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -outerInsets).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -outerInsets).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        titleLabel.textColor = HWColors.whitePrimary
        titleLabel.numberOfLines = 2
        imageView.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: outerInsets).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -HWInsets.extraSmall).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -outerInsets).isActive = true

        blurView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -outerInsets).isActive = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUrl)))
    }

    @objc func openUrl() {

        let safariView = SFSafariViewController(url: news.url)
        safariView.delegate = self
        safariView.dismissButtonStyle = .close
        safariView.preferredBarTintColor = UIColor.black

        self.viewController.present(safariView, animated: true, completion: nil)
    }

    public func setModel(_ news: News) {
        self.news = news

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

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
