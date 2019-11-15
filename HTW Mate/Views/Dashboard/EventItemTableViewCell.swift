//
//  EventCollectionViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class EventItemTableViewCell: UITableViewCell, EKEventEditViewDelegate, Dequeable {

	private var eventView		= UIView()
	private var dateLabel		= UILabel()
    private var titleLabel		= UILabel()
    private var subtitleLabel	= UILabel()

    public var viewController: UIViewController?
    private var event: Event!

    var isLongPressingOnEvent = false

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.selectionStyle = .none
		self.configureView()
	}

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureView() {
		contentView.layer.shadowColor	= HWColors.shadowDrop?.cgColor
		contentView.layer.shadowOpacity	= 0.2
		contentView.layer.shadowOffset	= CGSize(width: 0, height: 1)
		contentView.layer.shadowRadius	= 3
		
		contentView.addSubview(eventView)
	
		eventView.translatesAutoresizingMaskIntoConstraints			= false
		eventView.layer.cornerRadius								= HWInsets.CornerRadius.panel
		eventView.clipsToBounds										= true
		eventView.backgroundColor									= HWColors.coverBackground
		eventView.leadingAnchor.constraint(equalTo:					contentView.leadingAnchor,		constant: HWInsets.standard).isActive = true
		eventView.trailingAnchor.constraint(equalTo:				contentView.trailingAnchor,		constant: -HWInsets.standard).isActive = true
		eventView.topAnchor.constraint(equalTo:						contentView.topAnchor,			constant: HWInsets.standard / 2).isActive = true
		eventView.bottomAnchor.constraint(equalTo:					contentView.bottomAnchor,		constant: -HWInsets.standard / 2).isActive = true

		eventView.addSubview(dateLabel)
		dateLabel.translatesAutoresizingMaskIntoConstraints			= false
		dateLabel.font												= Font.shared.scaled(textStyle: .footnote, weight: .bold)
        dateLabel.textColor											= HWColors.secondaryText
        dateLabel.topAnchor.constraint(equalTo:						eventView.topAnchor,			constant: HWInsets.medium).isActive = true
		dateLabel.leadingAnchor.constraint(equalTo:					eventView.leadingAnchor,		constant: HWInsets.medium).isActive = true
		dateLabel.trailingAnchor.constraint(lessThanOrEqualTo:		eventView.trailingAnchor,		constant: -HWInsets.medium).isActive = true

        eventView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints		= false
		titleLabel.font												= Font.shared.scaled(textStyle: .callout, weight: .bold)
        titleLabel.textColor										= HWColors.primaryText
		titleLabel.numberOfLines									= 0
        titleLabel.leadingAnchor.constraint(equalTo:				eventView.leadingAnchor,		constant: HWInsets.medium).isActive = true
        titleLabel.topAnchor.constraint(equalTo:					dateLabel.bottomAnchor,			constant: HWInsets.extraSmall).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo:		eventView.trailingAnchor,		constant: -HWInsets.medium).isActive = true

        eventView.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints		= false
		subtitleLabel.font											= Font.shared.scaled(textStyle: .subheadline)
        subtitleLabel.textColor										= HWColors.primaryText
        subtitleLabel.numberOfLines									= 2
        subtitleLabel.leadingAnchor.constraint(equalTo:				eventView.leadingAnchor,		constant: HWInsets.medium).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo:					titleLabel.bottomAnchor,		constant: HWInsets.extraSmall).isActive = true
        subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo:	eventView.trailingAnchor,		constant: -HWInsets.medium).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo:				eventView.bottomAnchor,			constant: -HWInsets.medium).isActive = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUrl)))
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(saveEvent)))
    }

    @objc func openUrl() {
        guard !event.isSkeleton else { return }

        UIApplication.shared.open(event.url, options: [:], completionHandler: nil)
    }

    @objc func saveEvent(gestureReconizer: UILongPressGestureRecognizer) {
       if gestureReconizer.state == UIGestureRecognizer.State.began {
            if isLongPressingOnEvent { return }

            isLongPressingOnEvent = true
            self.addEventToCalendar()
        } else {
            isLongPressingOnEvent = false
        }
    }

    func addEventToCalendar() {
        guard !event.isSkeleton else { return }
        
        let eventStore = EKEventStore()
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if granted && error == nil {
                    let eventController = HWEventEditViewController()
                    eventController.eventStore = eventStore
                    eventController.eventModel = self.event
                    eventController.editViewDelegate = self
                    self.viewController?.present(eventController, animated: true, completion: nil)
				} else if !granted && error == nil && self.viewController != nil {
                    AlertManager(in: self.viewController!).insufficentPermission(for: .eventStore)
                }
            }
        })
    }

    public func setModel(_ event: Event) {
        self.event = event

		titleLabel.text = event.title
		subtitleLabel.text = event.subtitle
        
		let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateLabel.text = dateFormatter.string(from: event.date)
    }
	
	func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}
