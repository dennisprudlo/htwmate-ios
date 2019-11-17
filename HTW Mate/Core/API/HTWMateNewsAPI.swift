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
    func get(limit: Int?, completion: @escaping ([Article], URLResponse) -> Void) {
		var queryItems: [URLQueryItem]?
        if let safeLimit = limit {
            queryItems = [URLQueryItem(name: "limit", value: "\(safeLimit)")]
        }
		
		let components = API.shared.route(self.endpoint, queryItems: queryItems)

        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var news: [Article] = [Article]()
                    jsonArray.forEach({ (newsItem) in
						if let article = Article.from(json: newsItem) {
							news.append(article)
						}
                    })
                    completion(news, response)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
