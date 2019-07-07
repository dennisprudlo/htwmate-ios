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
    ///   - completion: The completion handler after a successful request
    func get(completion: @escaping ([News], URLResponse) -> Void) {

        let components = API.shared.route(self.endpoint, query: false)
        API.shared.get(route: components) { (data, response) in
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] {
                    var news: [News] = [News]()
                    jsonArray.forEach({ (newsItem) in

                        guard let id = newsItem.value(forKey: "id") as? Int else { return }
                        guard let title = newsItem.value(forKey: "title") as? String else { return }
                        guard let subtitle = newsItem.value(forKey: "description") as? String else { return }
                        guard let url = newsItem.value(forKey: "url") as? String else { return }
                        guard let imageUrl = newsItem.value(forKey: "image_url") as? String else { return }
                        guard let publishDate = newsItem.value(forKey: "created_at") as? String else { return }

                        guard let newsArticle = News(databaseId: id, title: title, subtitle: subtitle, url: url, imageUrl: imageUrl, publishDate: "2019-07-07") else { return }
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
