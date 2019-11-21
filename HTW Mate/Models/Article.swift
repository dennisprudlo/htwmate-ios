//
//  Article.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class Article {

    /// The news title
    var title: String

    /// The news subtitle
    var subtitle: String

    /// The url to the referring article
    var url: URL

    /// The url to the article header image
    var imageUrl: URL

	/// Whether the news article is a features article or not
	var isFeatured: Bool

    /// Initializes a news instance with the given parameters
    ///
    /// - Parameters:
    ///   - title: The news title
    ///   - subtitle: The news subtitle
    ///   - url: The url to the article
    ///   - imageUrl: The url to the article header image
	init(title: String, subtitle: String, url: URL, imageUrl: URL, featured: Bool) {
        self.title			= title
        self.subtitle		= subtitle
        self.url			= url
        self.imageUrl		= imageUrl
		self.isFeatured		= featured
    }
	
	public static func from(json dictionary: NSDictionary) -> Article? {
		guard
			let title			= dictionary.value(forKey: "title") as? String,
			let subtitle		= dictionary.value(forKey: "subtitle") as? String,
			let urlString		= dictionary.value(forKey: "url") as? String,
			let url				= URL(string: urlString),
			let imageUrlString	= dictionary.value(forKey: "image_url") as? String,
			let imageUrl		= URL(string: imageUrlString)
		else {
			return nil
		}
		
		let featured = dictionary.value(forKey: "featured") as? Bool ?? false
		
		return Article(title: title, subtitle: subtitle, url: url, imageUrl: imageUrl, featured: featured)
    }
	
	public func dict() -> NSDictionary {
		return [
			"title":		title,
			"subtitle":		subtitle,
			"url":			url.absoluteString,
			"image_url":	imageUrl.absoluteString,
			"featured":		isFeatured ? "1" : "0"
		]
	}
}
