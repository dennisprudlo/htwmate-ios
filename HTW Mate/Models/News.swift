//
//  News.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class News : DatabaseModel {

    /// The news title
    var title: String

    /// The news subtitle
    var subtitle: String

    /// The url to the referring article
    var url: URL

    /// The url to the article header image
    var imageUrl: URL

    /// The date the news was added to the feed
    var publishDate: Date

    /// Initializes a news instance with the given parameters
    ///
    /// - Parameters:
    ///   - id: The id to refer to in the database
    ///   - title: The news title
    ///   - subtitle: The news subtitle
    ///   - url: The url to the article
    ///   - imageUrl: The url to the article header image
    ///   - publishDate: The date the news was added to the feed
    init(databaseId id: Int, title: String, subtitle: String, url: URL, imageUrl: URL, publishDate: Date) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
        self.imageUrl = imageUrl
        self.publishDate = publishDate

        super.init(databaseId: id)
    }

    /// Initializes a news instance with the given parameters
    ///
    /// - Parameters:
    ///   - id: The id to refer to in the database
    ///   - title: The news title
    ///   - subtitle: The news subtitle
    ///   - url: The url to the article as as string. It will be parsed to a URL object automatically
    ///   - imageUrl: The url to the article header image as a string. It will be paresed to a URL object automatically
    ///   - publishDate: The date the news was added to the feed as a string in the format "YYY-MM-DD hh:mm:ss". It will be parsed to a Date object automatically
    convenience init?(databaseId id: Int, title: String, subtitle: String, url: String, imageUrl: String, publishDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let parsedUrl = URL(string: url), let parsedImageUrl = URL(string: imageUrl), let parsedPublishDate = dateFormatter.date(from: publishDate) else {
            return nil
        }

        self.init(databaseId: id, title: title, subtitle: subtitle, url: parsedUrl, imageUrl: parsedImageUrl, publishDate: parsedPublishDate)
    }
}
