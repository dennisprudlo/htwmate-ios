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

    public func reload() {
        guard let dashboardController = self.delegate else {
            return
        }

        self.loaded = false
        API.shared.eventsResource().get(limit: 6) { (events, response) in
            self.events = events
            self.loaded = true
            LogManager.shared.put("Dashboard events loaded")
            DispatchQueue.main.async {
                dashboardController.checkCollectionViewReload()
            }
        }
    }

    public func model(for indexPath: IndexPath) -> Event {
        return self.events[indexPath.row]
    }
}
