//
//  Bundle+DisplayName.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/20/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
