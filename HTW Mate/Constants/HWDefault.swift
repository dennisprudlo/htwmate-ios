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

    static func diningFilterRating(for rating: CafeteriaDish.Rating) -> Bool {
        return UserDefaults.standard.bool(forKey: "settings.dining.filter.rating.\(rating.rawValue)")
    }

    static func diningFilterRating(set newValue: Bool, for rating: CafeteriaDish.Rating) {
        UserDefaults.standard.set(newValue, forKey: "settings.dining.filter.rating.\(rating.rawValue)")
    }

    static func diningFilterBadge(for badge: CafeteriaDish.Badge) -> Bool {
        return UserDefaults.standard.bool(forKey: "settings.dining.filter.badge.\(badge.rawValue)")
    }

    static func diningFilterBadge(set newValue: Bool, for badge: CafeteriaDish.Badge) {
        UserDefaults.standard.set(newValue, forKey: "settings.dining.filter.badge.\(badge.rawValue)")
    }

    static func diningFilterAdditive(for additive: CafeteriaDish.Additive) -> Bool {
        return UserDefaults.standard.bool(forKey: "settings.dining.filter.additive.\(additive.rawValue)")
    }

    static func diningFilterAdditive(set newValue: Bool, for additive: CafeteriaDish.Additive) {
        UserDefaults.standard.set(newValue, forKey: "settings.dining.filter.additive.\(additive.rawValue)")
    }

    static func diningFilterAllergen(for allergen: CafeteriaDish.Allergen) -> Bool {
        return UserDefaults.standard.bool(forKey: "settings.dining.filter.allergen.\(allergen.rawValue)")
    }

    static func diningFilterAllergen(set newValue: Bool, for allergen: CafeteriaDish.Allergen) {
        UserDefaults.standard.set(newValue, forKey: "settings.dining.filter.allergen.\(allergen.rawValue)")
    }
}
