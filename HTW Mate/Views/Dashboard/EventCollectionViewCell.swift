//
//  EventCollectionViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import SafariServices
import EventKit
import EventKitUI

class EventCollectionViewCell: UICollectionViewCell, Dequeable, SFSafariViewControllerDelegate {

    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var dateView = UIView()
    private var dateMonthLabel = UILabel()
    private var dateDayLabel = UILabel()

    private var viewController: UIViewController!
    private var event: Event!

    var isLongPressingOnEvent = false

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

        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.backgroundColor = HWColors.darkPrimary
        setupDateView()
        contentView.addSubview(dateView)

        dateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: outerInsets).isActive = true
        dateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: outerInsets).isActive = true
        dateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -outerInsets).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: 50).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        titleLabel.textColor = HWColors.darkPrimary
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: outerInsets).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: outerInsets).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerInsets).isActive = true

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .regular)
        subtitleLabel.textColor = HWColors.darkPrimary
        subtitleLabel.numberOfLines = 2
        contentView.addSubview(subtitleLabel)

        subtitleLabel.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: outerInsets).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: HWInsets.extraSmall).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -outerInsets).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -outerInsets).isActive = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUrl)))
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(saveEvent)))
    }

    @objc func openUrl() {
        let safariView = SFSafariViewController(url: event.url)
        safariView.delegate = self
        safariView.dismissButtonStyle = .close
        safariView.preferredBarTintColor = UIColor.black

        self.viewController.present(safariView, animated: true, completion: nil)
    }

    @objc func saveEvent(gestureReconizer: UILongPressGestureRecognizer) {
       if gestureReconizer.state == UIGestureRecognizer.State.began {
            if isLongPressingOnEvent { return }

            isLongPressingOnEvent = true
            self.addEventToCalendar(date: self.event.date)
        } else {
            isLongPressingOnEvent = false
        }
    }

    func addEventToCalendar(date: Date) {
        let eventStore = EKEventStore()
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = self.event.title
                    event.notes = self.event.subtitle
                    event.url = self.event.url
                    event.isAllDay = true

                    event.startDate = date
                    event.endDate = date

                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = eventStore
                    eventController.editViewDelegate = self
                    self.viewController.present(eventController, animated: true, completion: nil)
                }
            }
        })
    }

    private func setupDateView() {
        let outerInsets = HWInsets.small

        dateMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        dateMonthLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        dateMonthLabel.textColor = HWColors.whitePrimary
        dateMonthLabel.numberOfLines = 1
        dateMonthLabel.textAlignment = .center
        dateView.addSubview(dateMonthLabel)

        dateMonthLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: outerInsets).isActive = true
        dateMonthLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: outerInsets).isActive = true
        dateMonthLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -outerInsets).isActive = true

        dateDayLabel.translatesAutoresizingMaskIntoConstraints = false
        dateDayLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
        dateDayLabel.textColor = HWColors.whitePrimary
        dateDayLabel.numberOfLines = 1
        dateDayLabel.textAlignment = .center
        dateView.addSubview(dateDayLabel)

        dateDayLabel.leadingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: outerInsets).isActive = true
        dateDayLabel.bottomAnchor.constraint(equalTo: dateView.bottomAnchor, constant: -outerInsets).isActive = true
        dateDayLabel.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -outerInsets).isActive = true

        dateDayLabel.topAnchor.constraint(equalTo: dateMonthLabel.bottomAnchor).isActive = true
    }
    
    public func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    public func setModel(_ event: Event) {
        self.event = event

        setTitle(event.title)
        setSubtitle(event.subtitle)
        setDate(event.date)
    }

    public func setTitle(_ title: String) {
        titleLabel.text = title
    }

    public func setSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }

    public func setDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: date)

        dateFormatter.dateFormat = "LLL"
        let month = dateFormatter.string(from: date)

        dateMonthLabel.text = month.uppercased()
        dateDayLabel.text = day
    }

}

extension EventCollectionViewCell: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
