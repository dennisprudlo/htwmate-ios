//
//  HWEventEditViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import EventKitUI

class HWEventEditViewController: EKEventEditViewController {

    var eventModel: Event! {
        didSet {
            prepareView()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNeedsStatusBarAppearanceUpdate()
    }

    private func prepareView() {
        let event = EKEvent(eventStore: eventStore)
        event.title = self.eventModel.title
        event.notes = self.eventModel.subtitle
        event.url = self.eventModel.url

        event.isAllDay = true

        event.startDate = self.eventModel.date
        event.endDate = self.eventModel.date
        self.event = event
    }

}
