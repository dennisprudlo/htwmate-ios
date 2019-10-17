//
//  DashboardNewsStorage.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class DashboardNewsStorage {

    static let shared: DashboardNewsStorage = DashboardNewsStorage()

    var delegate: DashboardController?
    var loaded: Bool = false

    var news: [News] = [
        News(), News(), News(), News(), News()
    ]

    public func reload() {
        guard let dashboardController = self.delegate else {
            return
        }

        self.loaded = false
        API.shared.newsResource().get(limit: 10) { (news, response) in
            self.news = news
            self.loaded = true
            DispatchQueue.main.async {
                dashboardController.checkCollectionViewReload()
            }
        }
    }

    public func model(for indexPath: IndexPath) -> News {
        return self.news[indexPath.row]
    }
}
