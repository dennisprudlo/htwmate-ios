//
//  CafeteriaDish.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/27/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class CafeteriaDish {

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

    enum Rating: String, CaseIterable {
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

    enum Badge: String, CaseIterable {
        case vegan = "BADGE_VEGAN"
        case climateFriendly = "BADGE_CLIMATE"
        case vegetarian = "BADGE_VEGETARIAN"
        case sustainable = "BADGE_SUSTAINABLE"
        case sustainableFish = "BADGE_SUSTAINABLE_FISH"
    }

    enum Additive: String, CaseIterable {
        case porkGelatine = "INGREDIENT_ADD_PORK_GELATINE"
        case alcohol = "INGREDIENT_ADD_ALCOHOL"
        case flavorEnhancer = "INGREDIENT_ADD_FLAVOR_ENHANCER"
        case waxed = "INGREDIENT_ADD_WAXED"
        case preservative = "INGREDIENT_ADD_PRESERVATIVE"
        case antioxidant = "INGREDIENT_ADD_ANTIOXIDANT"
        case artificialColors = "INGREDIENT_ADD_ARTIFICIAL_COLORS"
        case phosphate = "INGREDIENT_ADD_PHOSPHATE"
        case blackened = "INGREDIENT_ADD_BLACKENED"
        case phenylalanine = "INGREDIENT_ADD_PHENYLALANINE"
        case artificialSweeteners = "INGREDIENT_ADD_ARTIFICIAL_SWEETENERS"
        case finelyGroundMeat = "INGREDIENT_ADD_FINELY_GROUND_MEAT"
        case caffeine = "INGREDIENT_ADD_CAFFEINE"
        case quinine = "INGREDIENT_ADD_QUININE"
        case sulphuretted = "INGREDIENT_ADD_SULPHURETTED"
        case laxativeEffect = "INGREDIENT_ADD_LAXATIVE_EFFECT"
    }

    enum Allergen: String, CaseIterable {
        case glutenFromGrain = "INGREDIENT_ALG_GLUTEN_FROM_GRAIN"
        case wheat = "INGREDIENT_ALG_WHEAT"
        case rye = "INGREDIENT_ALG_RYE"
        case barley = "INGREDIENT_ALG_BARLEY"
        case oat = "INGREDIENT_ALG_OAT"
        case spelt = "INGREDIENT_ALG_SPELT"
        case kamut = "INGREDIENT_ALG_KAMUT"
        case crustacean = "INGREDIENT_ALG_CRUSTACEANS"
        case eggs = "INGREDIENT_ALG_EGGS"
        case fish = "INGREDIENT_ALG_FISH"
        case peanuts = "INGREDIENT_ALG_PEANUTS"
        case shellFruits = "INGREDIENT_ALG_SHELL_FRUITS"
        case almonds = "INGREDIENT_ALG_ALMONDS"
        case hazelnut = "INGREDIENT_ALG_HAZELNUT"
        case walnut = "INGREDIENT_ALG_WALNUT"
        case cashewNut = "INGREDIENT_ALG_CASHEW_NUT"
        case pecans = "INGREDIENT_ALG_PECANS"
        case brazilNut = "INGREDIENT_ALG_BRAZIL_NUT"
        case pistachio = "INGREDIENT_ALG_PISTACHIO"
        case macadamia = "INGREDIENT_ALG_MACADAMIA"
        case celery = "INGREDIENT_ALG_CELERY"
        case soyProtein = "INGREDIENT_ALG_SOY_PROTEIN"
        case mustarde = "INGREDIENT_ALG_MUSTARDE"
        case milkDairyLactose = "INGREDIENT_ALG_MILK_DAIRY_LACTOSE"
        case sesameSeed = "INGREDIENT_ALG_SESAME_SEED"
        case sulphurOxideSulfide = "INGREDIENT_ALG_SULPHUR_OXIDE_SULFIDE"
        case lupine = "INGREDIENT_ALG_LUPINE"
        case molluscs = "INGREDIENT_ALG_MOLLUSCS"
        case nitriteCuringSalt = "INGREDIENT_ALG_NITRITE_CURING_SALT"
        case yeast = "INGREDIENT_ALG_YEAST"
    }

    typealias Ingredient = (identifier: String, number: String, isAllergen: Bool)

    let cafeteria: CafeteriaDish.Cafeteria
    let category: CafeteriaDish.Category
    let rating: CafeteriaDish.Rating
    let title: String
    let prices: CafeteriaDish.Prices
    let badges: [CafeteriaDish.Badge]
    let ingredients: [CafeteriaDish.Ingredient]

    init(cafeteria: Cafeteria, category: Category, rating: Rating, title: String, prices: Prices, badges: [Badge], ingredients: [Ingredient]) {
        self.cafeteria		= cafeteria
        self.category		= category
        self.rating			= rating
        self.title			= title
        self.prices			= prices
        self.badges			= badges
        self.ingredients	= ingredients
	}

    public static func from(json dictionary: NSDictionary) -> CafeteriaDish {
        let cafeteria	= Cafeteria.init(rawValue: dictionary.value(forKey: "campus") as? String ?? "") ?? Cafeteria.treskowallee
        let category	= Category.init(rawValue: dictionary.value(forKey: "category") as? String ?? "") ?? Category.main
        let rating		= Rating.init(rawValue: dictionary.value(forKey: "rating") as? String ?? "") ?? Rating.undefined
        let title		= dictionary.value(forKey: "title") as? String ?? "Undefined"

        let priceStudent	= dictionary.value(forKey: "price_student") as? Double ?? 0
        let priceEmplyoee	= dictionary.value(forKey: "price_employee") as? Double ?? 0
        let priceRegular	= dictionary.value(forKey: "price_regular") as? Double ?? 0
        let prices			= Prices(student: priceStudent, employee: priceEmplyoee, regular: priceRegular)

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

        return CafeteriaDish(cafeteria: cafeteria, category: category, rating: rating, title: title, prices: prices, badges: badges, ingredients: ingredients)
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

    public func getBadgeViews(withFullTitle fullTitle: Bool = false) -> [(badge: Badge, title: String?, color: UIColor?, view: UIView)] {
        var badgeViews: [(badge: Badge, title: String?, color: UIColor?, view: UIView)] = []

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
                customInfo.text = fullTitle ? "sustainable fisheries" : "sust. fish."
                customInfo.color = HWColors.Cafeteria.badgeSustainableFish
            }

            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = customInfo.color
            view.layer.cornerRadius = HWInsets.CornerRadius.label

            let label = UILabel()
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontSizeToFitWidth	= false
            label.numberOfLines				= 1
            label.text						= customInfo.text?.uppercased()
            label.textAlignment				= .center
            label.textColor					= .white
			label.font						= Font.shared.scaled(textStyle: .caption2, weight: .black)
            
			label.leadingAnchor.constraint(equalTo:		view.leadingAnchor, constant: HWInsets.small).isActive = true
            label.topAnchor.constraint(equalTo:			view.topAnchor).isActive = true
			label.trailingAnchor.constraint(equalTo:	view.trailingAnchor, constant: -HWInsets.small).isActive = true
            label.bottomAnchor.constraint(equalTo:		view.bottomAnchor).isActive = true

            badgeViews.append((badge: badge, title: customInfo.text, color: customInfo.color, view: view))
        }

        return badgeViews
    }

    public func getInfoCells() -> [UITableViewCell] {
        var infoCells: [UITableViewCell] = []

        let cell = CafeteriaDishInfoMainTableViewCell()
        cell.titleLabel.text = self.title
		cell.ratingView.backgroundColor = self.getColor()
        infoCells.append(cell)

        let badgesData = getBadgeViews()
        if badgesData.count > 0 {
            let badgeTitle = CafeteriaDishTitleTableViewCell()
            badgeTitle.titleLabel.text = HWStrings.Controllers.Dining.sectionTitleBadge
            infoCells.append(badgeTitle)

            badgesData.forEach { (badgeData) in
                let badgeCell = CafeteriaDishAttributeTableViewCell()
                badgeCell.setColor(badgeData.color)
                badgeCell.setSymbol(" ")
                badgeCell.setDescription(CafeteriaDish.localizedDescription(forBadge: badgeData.badge))
                infoCells.append(badgeCell)
            }
        }

        var additives: [CafeteriaDishAttributeTableViewCell] = []
        var allergens: [CafeteriaDishAttributeTableViewCell] = []
        ingredients.forEach { (ingredient) in
            let ingredientCell = CafeteriaDishAttributeTableViewCell()
            ingredientCell.setSymbol(ingredient.number)
            ingredientCell.setDescription(CafeteriaDish.localizedDescription(forIngredientWithIdentifier: ingredient.identifier))
            if ingredient.isAllergen {
                allergens.append(ingredientCell)
            } else {
                additives.append(ingredientCell)
            }
        }

        if additives.count > 0 {
            let additivesTitleCell = CafeteriaDishTitleTableViewCell()
            additivesTitleCell.titleLabel.text = HWStrings.Controllers.Dining.sectionTitleAdditive
            infoCells.append(additivesTitleCell)

            additives.forEach { (cell) in
                infoCells.append(cell)
            }
        }

        if allergens.count > 0 {
            let allergensTitleCell = CafeteriaDishTitleTableViewCell()
            allergensTitleCell.titleLabel.text = HWStrings.Controllers.Dining.sectionTitleAllergen
            infoCells.append(allergensTitleCell)

            allergens.forEach { (cell) in
                infoCells.append(cell)
            }
        }

        return infoCells
    }

    public func getColor() -> UIColor? {
        switch rating {
        case .green: return HWColors.Cafeteria.ratingGreen
        case .orange: return HWColors.Cafeteria.ratingOrange
        case .red: return HWColors.Cafeteria.ratingRed
        case .undefined: return HWColors.Cafeteria.ratingUndefined
        }
    }

    public static func getColor(ofRating rating: CafeteriaDish.Rating) -> UIColor? {
        switch rating {
        case .green: return HWColors.Cafeteria.ratingGreen
        case .orange: return HWColors.Cafeteria.ratingOrange
        case .red: return HWColors.Cafeteria.ratingRed
        case .undefined: return HWColors.Cafeteria.ratingUndefined
        }
    }

    public func getPriceLabels() -> (student: String, other: String?) {
        if prices.isFree() {
            return (student: HWStrings.Controllers.Dining.pricesFree, other: nil)
        }

        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1

        let studentPrice = numberFormatter.string(from: prices.student as NSNumber)
        let employeePrice = numberFormatter.string(from: prices.employee as NSNumber)
        let regularPrice = numberFormatter.string(from: prices.regular as NSNumber)

        let studentText = "\(studentPrice ?? String(prices.student)) €"
        let otherText = "\(regularPrice ?? String(prices.regular)) / \(employeePrice ?? String(prices.employee)) /"

        return (student: studentText, other: otherText)
    }

    public static func localizedDescription(forBadge badge: Badge) -> String {
        switch badge {
        case .vegan: return HWStrings.Controllers.Dining.Badges.vegan
        case .climateFriendly: return HWStrings.Controllers.Dining.Badges.climateFriendly
        case .vegetarian: return HWStrings.Controllers.Dining.Badges.vegetarian
        case .sustainable: return HWStrings.Controllers.Dining.Badges.sustainable
        case .sustainableFish: return HWStrings.Controllers.Dining.Badges.sustainableFish
        }
    }

    public static func localizedDescription(forRating rating: CafeteriaDish.Rating) -> (leading: String, trailing: String) {
        var descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.undefinedLeading
        var descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.undefinedTrailing

        switch rating {
        case .green:
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.greenLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.greenTrailing
        case .orange:
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.orangeLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.orangeTrailing
        case .red:
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.redLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.redTrailing
        case .undefined:
            descriptionTextLeading = HWStrings.Controllers.Dining.Ratings.undefinedLeading
            descriptionTextTrailing = HWStrings.Controllers.Dining.Ratings.undefinedTrailing
        }

        return (leading: descriptionTextLeading, trailing: descriptionTextTrailing)
    }

    public static func localizedDescription(forIngredientWithIdentifier ingredient: String) -> String {
        let identifierString = "controller.dining.ingredients.\(ingredient)"
        return NSLocalizedString(identifierString, comment: "")
    }
}
