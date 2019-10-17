//
//  DashboardEventStorage.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class DashboardEventStorage {

    static let shared: DashboardEventStorage = DashboardEventStorage()

    var delegate: DashboardController?
    var loaded: Bool = false

    var events: [Event] = [
        Event(), Event(), Event(), Event(), Event(), Event()
    ]

    var allEvents: [Event] = []

    public func reload() {
        guard let dashboardController = self.delegate else {
            return
        }

        self.loaded = false
        API.shared.eventsResource().get(limit: nil) { (events, response) in
			self.allEvents = events
			self.events = Array(self.allEvents.prefix(10))
            self.loaded = true
            DispatchQueue.main.async {
                dashboardController.checkCollectionViewReload()
            }
        }
    }

    public func model(for indexPath: IndexPath) -> Event {
        return self.events[indexPath.row]
    }
}
