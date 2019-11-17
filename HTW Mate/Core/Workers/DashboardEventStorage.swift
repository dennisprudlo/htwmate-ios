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
	var reloadData: Bool = false

    var events: [Event] = []
    var allEvents: [Event] = []
	
	init() {
		retrieveFromCache()
	}

    public func reload() {
        guard let dashboardController = self.delegate else {
            return
        }

        self.loaded = false
		self.reloadData = false
        API.shared.eventsResource().get(limit: nil) { (events, response) in
			
			if self.differencesWith(events: events) {
				self.reloadData = true
			}
			
			self.allEvents = events
			self.events = Array(self.allEvents.prefix(10))
			self.writeToCache()
			
            self.loaded = true
            DispatchQueue.main.async {
                dashboardController.checkCollectionViewReload()
            }
        }
    }

    public func model(for indexPath: IndexPath) -> Event {
        return self.events[indexPath.row]
    }
	
	private func differencesWith(events: [Event]) -> Bool {
		if self.allEvents.count != events.count {
			return true
		}
		
		for index in 0..<events.count {
			let a = events[index]
			let b = self.allEvents[index]
			
			if a.title != b.title || a.subtitle != b.subtitle || a.url.absoluteString != b.url.absoluteString || a.date.timeIntervalSince1970 != b.date.timeIntervalSince1970 {
				return true
			}
		}
		
		return false
	}
	
	private func retrieveFromCache() -> Void {
		guard let cacheArray = UserDefaults.standard.array(forKey: "cache.events") as? [NSDictionary] else {
			return
		}
		
		self.events = []
		self.allEvents = []
		
		cacheArray.forEach { (eventItem) in
			if let event = Event.from(json: eventItem) {
				self.allEvents.append(event)
			}
		}
		
		self.events = Array(self.allEvents.prefix(10))
	}
	
	private func writeToCache() -> Void {
		var cacheArray: [NSDictionary] = []
		allEvents.forEach { (event) in
			cacheArray.append(event.dict())
		}
		
		UserDefaults.standard.set(cacheArray, forKey: "cache.events")
	}
}
