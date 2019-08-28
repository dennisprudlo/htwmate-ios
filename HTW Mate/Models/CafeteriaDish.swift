//
//  CafeteriaDish.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

class CafeteriaDish : DatabaseModel {

    enum Cafeteria: String {
        case treskowallee = "CAMPUS_TRESKOWALLEE"
        case wilhelminenhof = "CAMPUS_WILHELMINENHOF"
    }

    enum Category: String {
        case appetizer = "CATEGORY_APPETIZER"
        case salad = "CATEGORY_SALAD"
        case soup = "CATEGORY_SOUP"
        case special = "CATEGORY_SPECIAL"
        case main = "CATEGORY_MAIN"
        case side = "CATEGORY_SIDE"
        case dessert = "CATEGORY_DESSERT"
    }

    enum Rating: String {
        case green = "RATING_GREEN"
        case orange = "RATING_ORANGE"
        case red = "RATING_RED"
        case undefined = "RATING_UNDEFINED"
    }

    struct Prices {
        let student: Double
        let employee: Double
        let regular: Double

        func isFree () -> Bool {
            return (student + employee + regular) == 0
        }
    }

    enum Badge: String {
        case vegan = "BADGE_VEGAN"
        case climateFriendly = "BADGE_CLIMATE"
        case vegetarian = "BADGE_VEGETARIAN"
        case sustainable = "BADGE_SUSTAINABLE"
        case sustainableFish = "BADGE_SUSTAINABLE_FISH"
    }

    typealias Ingredient = (identifier: String, number: String, isAllergen: Bool)

    let cafeteria: CafeteriaDish.Cafeteria
    let category: CafeteriaDish.Category
    let rating: CafeteriaDish.Rating
    let title: String
    let prices: CafeteriaDish.Prices
    let badges: [CafeteriaDish.Badge]
    let ingredients: [CafeteriaDish.Ingredient]

    init(databaseId: Int, cafeteria: Cafeteria, category: Category, rating: Rating, title: String, prices: Prices, badges: [Badge], ingredients: [Ingredient]) {
        self.cafeteria = cafeteria
        self.category = category
        self.rating = rating
        self.title = title
        self.prices = prices
        self.badges = badges
        self.ingredients = ingredients

        super.init(databaseId: databaseId)
    }

    public static func from(json dictionary: NSDictionary) -> CafeteriaDish {
        let databaseId = dictionary.value(forKey: "id") as? Int ?? 0

        let cafeteria = Cafeteria.init(rawValue: dictionary.value(forKey: "campus") as? String ?? "") ?? Cafeteria.treskowallee
        let category = Category.init(rawValue: dictionary.value(forKey: "category") as? String ?? "") ?? Category.main
        let rating = Rating.init(rawValue: dictionary.value(forKey: "rating") as? String ?? "") ?? Rating.undefined
        let title = dictionary.value(forKey: "title") as? String ?? "Undefined"

        let priceStudent = dictionary.value(forKey: "price_student") as? Double ?? 0
        let priceEmplyoee = dictionary.value(forKey: "price_employee") as? Double ?? 0
        let priceRegular = dictionary.value(forKey: "price_regular") as? Double ?? 0
        let prices = Prices(student: priceStudent, employee: priceEmplyoee, regular: priceRegular)

        var badges: [Badge] = []
        (dictionary.value(forKey: "badges") as? [String] ?? []).forEach { (badge) in
            if let badgeCase = Badge.init(rawValue: badge) {
                badges.append(badgeCase)
            }
        }

        var ingredients: [Ingredient] = []
        (dictionary.value(forKey: "ingredients") as? [NSDictionary] ?? []).forEach { (ingredient) in
            let identifier = ingredient.value(forKey: "identifier") as? String ?? "INGREDIENT_UNDEFINED"
            let number = ingredient.value(forKey: "number") as? String ?? "0"
            let isAllergen = ingredient.value(forKey: "allergen") as? Int ?? 0

            ingredients.append(Ingredient(identifier: identifier, number: number, isAllergen: isAllergen == 1))
        }

        return CafeteriaDish(databaseId: databaseId, cafeteria: cafeteria, category: category, rating: rating, title: title, prices: prices, badges: badges, ingredients: ingredients)
    }

    public func getIngredientsNumberChain() -> String? {
        if self.ingredients.count == 0 {
            return nil
        }

        var output = "("
        for index in 0..<self.ingredients.count {
            let number = self.ingredients[index].number
            output = output + number

            if index < self.ingredients.count - 1 {
                output = output + ", "
            }
        }
        return output + ")"
    }
}
