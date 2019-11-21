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
	var reloadData: Bool = false

    var articles: [Article] = []

	init() {
		retrieveFromCache()
	}
	
    public func reload() {
        guard let dashboardController = self.delegate else {
            return
        }

        self.loaded = false
		self.reloadData = false
        API.shared.newsResource().get(limit: 10) { (articles, response) in
			
			if self.differencesWith(articles: articles) {
				self.reloadData = true
			}
			
            self.articles = articles
			self.writeToCache()
            
			self.loaded = true
            DispatchQueue.main.async {
                dashboardController.checkCollectionViewReload()
            }
        }
    }

    public func model(for indexPath: IndexPath) -> Article {
        return self.articles[indexPath.row]
    }
	
	private func differencesWith(articles: [Article]) -> Bool {
		if self.articles.count != articles.count {
			return true
		}
		
		for index in 0..<articles.count {
			let a = articles[index]
			let b = self.articles[index]
			
			if a.title != b.title || a.subtitle != b.subtitle || a.url.absoluteString != b.url.absoluteString || a.imageUrl.absoluteString != b.imageUrl.absoluteString {
				return true
			}
		}
		
		return false
	}
	
	private func retrieveFromCache() -> Void {
		guard let cacheArray = UserDefaults.standard.array(forKey: "cache.articles") as? [NSDictionary] else {
			return
		}
		
		self.articles = []
		cacheArray.forEach { (articleItem) in
			if let article = Article.from(json: articleItem) {
				self.articles.append(article)
			}
		}
	}
	
	private func writeToCache() -> Void {
		var cacheArray: [NSDictionary] = []
		articles.forEach { (article) in
			cacheArray.append(article.dict())
		}
		
		UserDefaults.standard.set(cacheArray, forKey: "cache.articles")
	}
}
