//
//  NewsItemTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class NewsItemTableViewCell: UITableViewCell {

	private var articleView			= UIView()
	private var articleImageView	= UIImageView()
	private var featuredView		= UIView()
	private var featuredLabel		= UILabel()
	
	private var blurView			= UIVisualEffectView(effect: UIBlurEffect(style: .dark))
	private var titleLabel			= UILabel()
    private var subtitleLabel		= UILabel()
	
	private var article: News!
	
    public var viewController: DashboardController!
    
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.selectionStyle = .none
		self.contentView.layer.masksToBounds = false
		self.contentView.backgroundColor = UIColor(fromHexRed: 255, green: 0, blue: 0, alpha: 0)
		self.configureView()
	}

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureView() {
		contentView.addSubview(articleView)

		articleView.translatesAutoresizingMaskIntoConstraints		= false
		articleView.layer.cornerRadius								= HWInsets.CornerRadius.panel
		articleView.clipsToBounds									= true
		articleView.leadingAnchor.constraint(equalTo:				contentView.leadingAnchor, constant: HWInsets.standard).isActive = true
		articleView.trailingAnchor.constraint(equalTo:				contentView.trailingAnchor, constant: -HWInsets.standard).isActive = true
		articleView.topAnchor.constraint(equalTo:					contentView.topAnchor, constant: HWInsets.standard / 2).isActive = true
		articleView.bottomAnchor.constraint(equalTo:				contentView.bottomAnchor, constant: -HWInsets.standard / 2).isActive = true
		
		articleView.addSubview(articleImageView)
		articleImageView.translatesAutoresizingMaskIntoConstraints	= false
		articleImageView.contentMode = .scaleAspectFill
		articleImageView.pin(to: articleView)
		
		// Add featured label
		articleImageView.addSubview(featuredView)
		featuredView.translatesAutoresizingMaskIntoConstraints		= false
		featuredView.backgroundColor								= HWColors.StyleGuide.primaryGreen
		featuredView.layer.cornerRadius								= HWInsets.CornerRadius.label
		featuredView.isHidden										= true
		featuredView.topAnchor.constraint(equalTo:					articleImageView.topAnchor,			constant: HWInsets.decent).isActive = true
		featuredView.leadingAnchor.constraint(equalTo:				articleImageView.leadingAnchor,		constant: HWInsets.decent).isActive = true
		featuredView.trailingAnchor.constraint(lessThanOrEqualTo:	articleImageView.trailingAnchor,	constant: -HWInsets.decent).isActive = true

		featuredView.addSubview(featuredLabel)
		featuredLabel.translatesAutoresizingMaskIntoConstraints		= false
		featuredLabel.numberOfLines									= 1
		featuredLabel.text											= HWStrings.Controllers.Dashboard.newsFeatured
		featuredLabel.textAlignment									= .center
		featuredLabel.textColor										= .white
		featuredLabel.font											= Font.shared.scaled(textStyle: .footnote, weight: .bold)
		featuredLabel.leadingAnchor.constraint(equalTo:				featuredView.leadingAnchor, constant: HWInsets.small).isActive = true
		featuredLabel.topAnchor.constraint(equalTo:					featuredView.topAnchor).isActive = true
		featuredLabel.trailingAnchor.constraint(equalTo:			featuredView.trailingAnchor, constant: -HWInsets.small).isActive = true
		featuredLabel.bottomAnchor.constraint(equalTo:				featuredView.bottomAnchor).isActive = true

        //
        // Add visual effect view
		articleImageView.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints			= false
        blurView.leadingAnchor.constraint(equalTo:					articleImageView.leadingAnchor).isActive = true
		blurView.topAnchor.constraint(equalTo:						articleImageView.topAnchor, constant: 225).isActive = true
        blurView.trailingAnchor.constraint(equalTo:					articleImageView.trailingAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo:					articleImageView.bottomAnchor).isActive	= true

		articleImageView.addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints		= false
		titleLabel.font												= Font.shared.scaled(textStyle: .callout, weight: .bold)
		titleLabel.textColor										= .white
		titleLabel.numberOfLines									= 2
		titleLabel.leadingAnchor.constraint(equalTo:				articleImageView.leadingAnchor,		constant: HWInsets.medium).isActive = true
		titleLabel.topAnchor.constraint(equalTo:					blurView.topAnchor,					constant: HWInsets.medium).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo:				articleImageView.trailingAnchor,	constant: -HWInsets.medium).isActive = true

        articleImageView.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints		= false
		subtitleLabel.font											= Font.shared.scaled(textStyle: .subheadline)
        subtitleLabel.textColor										= .white
        subtitleLabel.numberOfLines									= 3
        subtitleLabel.leadingAnchor.constraint(equalTo:				articleImageView.leadingAnchor,		constant: HWInsets.medium).isActive = true
		subtitleLabel.topAnchor.constraint(equalTo:					titleLabel.bottomAnchor,			constant: HWInsets.extraSmall).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo:				articleImageView.bottomAnchor,		constant: -HWInsets.medium).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo:			articleImageView.trailingAnchor,	constant: -HWInsets.medium).isActive = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUrl)))
    }

    @objc private func openUrl() {
        guard !article.isSkeleton else { return }

        UIApplication.shared.open(article.url, options: [:], completionHandler: nil)
    }

    public func setModel(_ article: News) {
        self.article = article

        setTitle(article.title)
        setSubtitle(article.subtitle)

		featuredView.isHidden = !article.isFeatured

        blurView.isHidden = article.isSkeleton
        if article.isSkeleton {
			contentView.layer.shadowColor	= HWColors.shadowDrop?.cgColor
			contentView.layer.shadowOpacity	= 0.1
			contentView.layer.shadowOffset	= CGSize(width: 0, height: 1)
			contentView.layer.shadowRadius	= 4
        } else {
            contentView.layer.shadowColor	= HWColors.shadowDrop?.cgColor
			contentView.layer.shadowOpacity	= 0.3
			contentView.layer.shadowOffset	= CGSize(width: 0, height: 1)
			contentView.layer.shadowRadius	= 5
        }

		articleImageView.layer.borderColor = HWColors.StyleGuide.primaryGreen.cgColor
		articleImageView.layer.borderWidth = article.isFeatured ? 5 : 0

        guard article.databaseId != -1 else {
            return
        }
        
        DownloadManager.image(from: article.imageUrl) { (image) in
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
        articleImageView.image = image
    }
}
