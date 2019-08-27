//
//  CafeteriaStorage.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

protocol CafeteriaStorageDelegate {
    func cafeteriaStorage(didReloadDishes dishes: [CafeteriaDish])
}

class CafeteriaStorage {

    static let shared: CafeteriaStorage = CafeteriaStorage()

    let sections: [String] = [
        HWStrings.Controllers.Dining.Categories.appetizer,
        HWStrings.Controllers.Dining.Categories.salad,
        HWStrings.Controllers.Dining.Categories.soup,
        HWStrings.Controllers.Dining.Categories.special,
        HWStrings.Controllers.Dining.Categories.main,
        HWStrings.Controllers.Dining.Categories.side,
        HWStrings.Controllers.Dining.Categories.dessert
    ]
    var displayedSections: [String] = []
    var displayedCafeteriaDishes: [[CafeteriaDish]] = []

    private var cafeteriaDishes: [CafeteriaDish] = []

     var delegate: CafeteriaStorageDelegate?

    /// Reloads the cafeteria dishes from the API
    func reload(forDate date: Date, cafeteria: CafeteriaDish.Cafeteria) -> Void {
        var internationalized: Bool = true
        if let langCode = Locale.current.languageCode, langCode == "de" {
            internationalized = false
        }

        API.shared.cafeteriaResource().get(forDate: date, cafeteria: cafeteria, internationalied: internationalized, completion: { (cafeteriaDishes, response) in
            self.cafeteriaDishes = cafeteriaDishes
            self.buildDisplayedCafeteriaDishes()
        })
    }

    func buildDisplayedCafeteriaDishes() -> Void {
        displayedSections = []
        displayedCafeteriaDishes = []

        for index in 0..<sections.count {
            var category = CafeteriaDish.Category.main
            switch index {
            case 0: category = CafeteriaDish.Category.appetizer
            case 1: category = CafeteriaDish.Category.salad
            case 2: category = CafeteriaDish.Category.soup
            case 3: category = CafeteriaDish.Category.special
            case 4: category = CafeteriaDish.Category.main
            case 5: category = CafeteriaDish.Category.side
            case 6: category = CafeteriaDish.Category.dessert
            default: category = CafeteriaDish.Category.main
            }

            let filteredDishes = cafeteriaDishes.filter { (dishToCheck) -> Bool in
                return dishToCheck.category == category
            }

            if filteredDishes.count > 0 {
                displayedSections.append(sections[index])
                displayedCafeteriaDishes.append(filteredDishes)
            }
        }
        
        if delegate != nil {
            DispatchQueue.main.async {
                self.delegate!.cafeteriaStorage(didReloadDishes: self.cafeteriaDishes)
            }
        }
    }

    func titleForSection(_ section: Int) -> String? {
        guard section >= 0 && section < displayedSections.count else {
            return nil
        }
        return displayedSections[section]
    }

    func cafeteriaDishes(inSection section: Int) -> [CafeteriaDish] {
        guard section >= 0 && section < displayedCafeteriaDishes.count else {
            return []
        }

        return displayedCafeteriaDishes[section]
    }
}
