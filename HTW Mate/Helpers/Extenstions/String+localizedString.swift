//
//  String+localizedString.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

extension String {

    public func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }

}
