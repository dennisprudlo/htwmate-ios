//
//  Cache.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/29/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

struct Cache {
	
	enum Key: String {
		case certificates = "certificates"
	}
	
	static func write<T>(key: Key, _ data: T) {
		UserDefaults.standard.set(data, forKey: key.rawValue)
	}
	
	static func read(key: Key) -> [String]? {
		return UserDefaults.standard.array(forKey: key.rawValue) as? [String]
	}
}
