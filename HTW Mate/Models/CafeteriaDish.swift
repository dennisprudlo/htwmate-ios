//
//  CafeteriaDish.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

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

    public func getBadgeViews(withFullTitle fullTitle: Bool = false) -> [(badge: Badge, view: UIView)] {
        var badgeViews: [(badge: Badge, view: UIView)] = []

        badges.forEach { (badge) in

            var customInfo: (text: String?, color: UIColor?) = (text: nil, color: nil)
            switch badge {
            case .vegan:
                customInfo.text = "vegan"
                customInfo.color = HWColors.Cafeteria.badgeVegan
            case .climateFriendly:
                customInfo.text = fullTitle ? "climate friendly" : "climate fr."
                customInfo.color = HWColors.Cafeteria.badgeClimateFriendly
            case .vegetarian:
                customInfo.text = fullTitle ? "vegetarian" : "veget."
                customInfo.color = HWColors.Cafeteria.badgeVegetarian
            case .sustainable:
                customInfo.text = fullTitle ? "sustainable food" : "sust. food"
                customInfo.color = HWColors.Cafeteria.badgeSustainable
            case .sustainableFish:
                customInfo.text = fullTitle ? "sustainable fisheries" : "sust. fisheries"
                customInfo.color = HWColors.Cafeteria.badgeSustainableFish
            }

            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = customInfo.color
            view.layer.cornerRadius = HWInsets.CornerRadius.label

            let padding: CGFloat = HWInsets.small

            let label = UILabel()
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 1
            label.text = customInfo.text?.uppercased()
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: HWFontSize.label, weight: .bold)
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
            label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

            badgeViews.append((badge: badge, view: view))
        }

        return badgeViews
    }

    public func getInfoCells() -> [UITableViewCell] {
        var infoCells: [UITableViewCell] = []

        let ratingCell = CafeteriaDishRatingTableViewCell()
        ratingCell.rating = self.rating
        infoCells.append(ratingCell)

        let cell = CafeteriaDishInfoMainTableViewCell()
        cell.titleLabel.text = self.title
        infoCells.append(cell)

        getBadgeViews(withFullTitle: true).forEach { (badgeData) in
            let badgeCell = CafeteriaDishBadgeTableViewCell()
            badgeCell.setBadge(badgeData.view)
            badgeCell.descriptionLabel.text = localizedDescription(forBadge: badgeData.badge)
            infoCells.append(badgeCell)
        }

        return infoCells
    }

    public func localizedDescription(forBadge badge: Badge) -> String {
        switch badge {
        case .vegan: return HWStrings.Controllers.Dining.Badges.vegan
        case .climateFriendly: return HWStrings.Controllers.Dining.Badges.climateFriendly
        case .vegetarian: return HWStrings.Controllers.Dining.Badges.vegetarian
        case .sustainable: return HWStrings.Controllers.Dining.Badges.sustainable
        case .sustainableFish: return HWStrings.Controllers.Dining.Badges.sustainableFish
        }
    }
}
