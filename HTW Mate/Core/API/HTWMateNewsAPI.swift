//
//  HTWMateNewsAPI.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class HTWMateNewsAPI {

    /// The endpoint for the news resource
    let endpoint = "news"

    /// Gets all news articles
    ///
    /// - Parameters:
    ///   - limit: The amount of news articles to fetch. Gets all if nil is passed
    ///   - completion: The completion handler after a successful request
    func get(limit: Int?, completion: @escaping ([News], URLResponse) -> Void) {
		var queryItems: [URLQueryItem]?
        if let safeLimit = limit {
            queryItems = [URLQueryItem(name: "limit", value: "\(safeLimit)")]
        }
		
		let components = API.shared.route(self.endpoint, queryItems: queryItems)

        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var news: [News] = [News]()
                    jsonArray.forEach({ (newsItem) in

                        guard let id = newsItem.value(forKey: "id") as? Int else { return }
                        guard let title = newsItem.value(forKey: "title") as? String else { return }
                        guard let subtitle = newsItem.value(forKey: "subtitle") as? String else { return }
                        guard let url = newsItem.value(forKey: "url") as? String else { return }
                        guard let imageUrl = newsItem.value(forKey: "image_url") as? String else { return }
                        guard let featured = newsItem.value(forKey: "featured") as? Bool else { return }
                        guard let publishDate = newsItem.value(forKey: "created_at") as? String else { return }

						guard let newsArticle = News(databaseId: id, title: title, subtitle: subtitle, url: url, imageUrl: imageUrl, isFeatured: featured, publishDate: publishDate) else { return }
                        news.append(newsArticle)
                    })
                    completion(news, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
