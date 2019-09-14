//
//  HWDefault.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

struct HWDefault {

    // MARK: Cafeteria Defaults
    static var diningCampus: Int {
        get {
            return UserDefaults.standard.integer(forKey: "settings.dining.campus")
        }
        set (campusId) {
            UserDefaults.standard.set(campusId, forKey: "settings.dining.campus")
        }
    }

    static var diningIsFilterOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "settings.dining.isfilteron")
        }
        set (isOn) {
            UserDefaults.standard.set(isOn, forKey: "settings.dining.isfilteron")
        }
    }
}
