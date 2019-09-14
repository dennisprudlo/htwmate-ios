//
//  HWMetaContainer.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWMetaContainer {

    private static var container: [UIView: [String: Any?]] = [:]

    public static func write(_ data: Any?, forKey key: String, in view: UIView) {
        if self.container[view] == nil {
            self.container[view] = [:]
        }

        self.container[view]?[key] = data
    }

    public static func retrieve(fromKey key: String, of view: UIView) -> Any? {
        guard let containerContent = self.container[view] else {
            return nil
        }

        guard let data = containerContent[key] else {
            return nil
        }

        return data
    }
}
