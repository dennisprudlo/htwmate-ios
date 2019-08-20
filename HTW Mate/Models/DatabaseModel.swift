//
//  DatabaseModel.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class DatabaseModel {

    var databaseId: Int

    var isSkeleton: Bool {
        return databaseId == -1
    }

    init(databaseId: Int) {
        self.databaseId = databaseId
    }

}
