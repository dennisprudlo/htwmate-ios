//
//  HWMissingContentView.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWMissingContentView: UIView {

    enum DisplayType {
        case text(title: String, subtitle: String)
    }

    private var hideContentView: UIView?
    private let transparentColor = UIColor(fromHexRed: 0xFF, green: 0xFF, blue: 0xFF, alpha: 0x00)
    private let viewBackgroundColor: UIColor? = HWColors.contentBackground

    private let fadeTimeInterval: TimeInterval = 0.1 

    private let contentView = UIView()

    init(displayType type: DisplayType) {
        super.init(frame: CGRect.zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = self.transparentColor
        self.isOpaque = false

        buildContentView(forType: type)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func snap(toEdgesOf view: UIView, useSafeArea: Bool = false, useSafeAreaForContentView safeContent: Bool = true) {
        self.topAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor).isActive = true

        self.hideContentView = view
        view.sendSubviewToBack(self)

        let padding: CGFloat = 16
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        contentView.topAnchor.constraint(equalTo: safeContent ? view.safeAreaLayoutGuide.topAnchor : self.topAnchor, constant: padding).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        contentView.bottomAnchor.constraint(equalTo: safeContent ? view.safeAreaLayoutGuide.bottomAnchor : self.bottomAnchor, constant: -padding).isActive = true
    }

    func show (completion: (() -> Void)?) {
        guard let view = self.hideContentView else { return }

        view.bringSubviewToFront(self)

        UIView.animate(withDuration: fadeTimeInterval, animations: {
            self.backgroundColor = self.viewBackgroundColor
            self.contentView.layer.opacity = 1.0
        }) { (success) in
            guard let handler = completion else { return }

            handler()
        }
    }

    func hide () {
        guard let view = self.hideContentView else { return }

        UIView.animate(withDuration: fadeTimeInterval, animations: {
            self.backgroundColor = self.transparentColor
            self.contentView.layer.opacity = 0.0
        }, completion: { (success) in
            view.sendSubviewToBack(self)
        })
    }

    func buildContentView(forType type: DisplayType) {
        switch type {
        case .text(let title, let subtitle):
            let wrapperView = UIView()
            let titleLabel = UILabel()
            let subtitleLabel = UILabel()

            contentView.addSubview(wrapperView)
            wrapperView.addSubview(titleLabel)
            wrapperView.addSubview(subtitleLabel)

            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            wrapperView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            wrapperView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor).isActive = true
            wrapperView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
            wrapperView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true

            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = title
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.enlargedText, weight: .heavy)
            titleLabel.textColor = HWColors.darkSecondaryUltraLight
            titleLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
            titleLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true

            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.text = subtitle
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = .center
            subtitleLabel.font = UIFont.systemFont(ofSize: HWFontSize.strongText, weight: .semibold)
            subtitleLabel.textColor = HWColors.darkSecondaryUltraLight
            subtitleLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
            subtitleLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
            subtitleLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true

            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -4).isActive = true
        }
    }

}
