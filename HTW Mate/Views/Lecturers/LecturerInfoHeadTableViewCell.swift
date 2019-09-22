//
//  LecturerInfoHeadTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/31/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import MessageUI

class LecturerInfoHeadTableViewCell: LecturerInfoTableViewCell, MFMailComposeViewControllerDelegate {

    let lecturerImageView = UIImageView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let quickActionStack = UIStackView(arrangedSubviews: [])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setupUI(withHeadline headline: String? = nil) {
        super.setupUI()

        contentView.addSubview(lecturerImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(quickActionStack)

        let inset = HWInsets.medium
        let imageSize: CGFloat = 80

        lecturerImageView.translatesAutoresizingMaskIntoConstraints = false
        lecturerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        lecturerImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lecturerImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        lecturerImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        lecturerImageView.image = HWImage.lecturersProfilePlaceholder

        lecturerImageView.layer.cornerRadius = imageSize / 2
        lecturerImageView.clipsToBounds = true
		lecturerImageView.tintColor = HWColors.lecturerPlaceholderTint

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .bold)
        titleLabel.textColor = HWColors.darkSecondaryUltraLight
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: lecturerImageView.bottomAnchor, constant: inset).isActive = true

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: HWFontSize.title, weight: .bold)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: inset).isActive = true
        nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -inset).isActive = true

        quickActionStack.translatesAutoresizingMaskIntoConstraints = false
        quickActionStack.axis = .horizontal
        quickActionStack.alignment = .fill
        quickActionStack.distribution = .fill
        quickActionStack.spacing = 32
        quickActionStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        quickActionStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: inset * 2).isActive = true
        quickActionStack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        quickActionStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset).isActive = true
    }

    override func reload() {
        super.reload()
        let lecturer: Lecturer! = tableViewController.lecturer

        lecturerImageView.image = lecturer.image
        titleLabel.text = lecturer.title
        nameLabel.text = lecturer.getFullName()

        quickActionStack.removeAllArrangedSubviews()
        var stackType = 1
        lecturer.getQuickActionSubviews().forEach { (subview) in
            quickActionStack.addArrangedSubview(subview)
            if let stack = subview as? UIStackView, let actionView = stack.arrangedSubviews.first {
                switch stackType {
                case 1: actionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMail(_:))))
                case 2: actionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCall(_:))))
                case 3: actionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapVisit(_:))))
                default: break
                }
            }

            stackType += 1
        }
    }

    @objc private func didTapMail(_ sender: UITapGestureRecognizer) {
        let lecturer: Lecturer! = tableViewController.lecturer

        guard let mail = lecturer.mail else {
            return
        }

        if MFMailComposeViewController.canSendMail() {
            let mailController = MFMailComposeViewController()
            mailController.setToRecipients([mail])
            mailController.setMessageBody("", isHTML: false)
            mailController.mailComposeDelegate = self
            mailController.navigationBar.tintColor = HWColors.StyleGuide.primaryGreen

            tableViewController.present(mailController, animated: true)
        } else {
            return AlertManager(in: tableViewController)
                .with(title: HWStrings.Alerts.missingMailAccount.title)
                .with(message: HWStrings.Alerts.missingMailAccount.description)
                .dispatch()
        }
    }

    @objc private func didTapCall(_ sender: UITapGestureRecognizer) {
        let lecturer: Lecturer! = tableViewController.lecturer

        var number: String?
        if lecturer.hasMobile() {
            number = lecturer.mobile
        } else if lecturer.hasPhone() {
            number = lecturer.phone
        }
        if let flattenedNumber = number?.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "") {
            if let url = URL(string: "telprompt://\(flattenedNumber)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    @objc private func didTapVisit(_ sender: UITapGestureRecognizer) {
        let lecturer: Lecturer! = tableViewController.lecturer

        guard let website = lecturer.websiteUrl else {
            return
        }

        UIApplication.shared.open(website, options: [:], completionHandler: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
