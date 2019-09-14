//
//  SettingsDiningController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsDiningController: UITableViewController {

    enum SectionType: CaseIterable {
        case campus
        case filter
        case rating
        case badges
        case additives
        case allergens
    }

    let sections: [(type: SectionType, header: String?, footer: String?)] = [
        (type: .campus, header: nil, footer: HWStrings.Controllers.Settings.Dining.campusDescription),
        (type: .filter, header: nil, footer: nil),
        (type: .rating, header: HWStrings.Controllers.Dining.sectionTitleRating, footer: nil),
        (type: .badges, header: HWStrings.Controllers.Dining.sectionTitleBadge, footer: nil),
        (type: .additives, header: HWStrings.Controllers.Dining.sectionTitleAdditive, footer: nil),
        (type: .allergens, header: HWStrings.Controllers.Dining.sectionTitleAllergen, footer: nil)
    ]

    let campusCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
    let filterCell = UITableViewCell(style: .default, reuseIdentifier: nil)
    let filterSwitch = UISwitch()

    var ratingCells: [UITableViewCell] = []
    var badgesCells: [UITableViewCell] = []
    var additivesCells: [UITableViewCell] = []
    var allergensCells: [UITableViewCell] = []

    var overrideTitle: String?
    var navigationBar: UINavigationBar?

    let campusTitles = ["Treskowallee", "Wilhelminenhof"]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = overrideTitle {
            self.title = title
        } else {
            self.title = HWStrings.Controllers.Dining.title
        }

        configureCells()
    }

    func configureCells() {
        self.campusCell.textLabel?.text = HWStrings.Controllers.Settings.Dining.campus

        self.filterCell.textLabel?.text = HWStrings.Controllers.Settings.Dining.filter
        self.filterCell.selectionStyle = .none
        self.filterCell.accessoryView = self.filterSwitch
        self.filterSwitch.addTarget(self, action: #selector(filterSwitchChanged), for: .valueChanged)

        CafeteriaDish.Rating.allCases.forEach { (rating) in
            if rating == .undefined { return }

            let ratingCell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

            let localized = CafeteriaDish.localizedDescription(forRating: rating)
            ratingCell.textLabel?.text = localized.leading
            ratingCell.textLabel?.font = UIFont.systemFont(ofSize: ratingCell.textLabel?.font.pointSize ?? HWFontSize.text, weight: .semibold)
            ratingCell.textLabel?.textColor = CafeteriaDish.getColor(ofRating: rating)
            ratingCell.detailTextLabel?.text = localized.trailing

            HWMetaContainer.write(rating, forKey: "rating", in: ratingCell)

            ratingCells.append(ratingCell)
        }

        CafeteriaDish.Badge.allCases.forEach { (badge) in
            let badgeCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            badgeCell.textLabel?.text = CafeteriaDish.localizedDescription(forBadge: badge)
            badgeCell.textLabel?.numberOfLines = 0

            HWMetaContainer.write(badge, forKey: "badge", in: badgeCell)

            badgesCells.append(badgeCell)
        }

        CafeteriaDish.Additive.allCases.forEach { (additive) in
            let additiveCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            additiveCell.textLabel?.text = CafeteriaDish.localizedDescription(forIngredientWithIdentifier: additive.rawValue)
            additiveCell.textLabel?.numberOfLines = 0

            HWMetaContainer.write(additive, forKey: "additive", in: additiveCell)

            additivesCells.append(additiveCell)
        }

        CafeteriaDish.Allergen.allCases.forEach { (allergen) in
            let allergenCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            allergenCell.textLabel?.text = CafeteriaDish.localizedDescription(forIngredientWithIdentifier: allergen.rawValue)
            allergenCell.textLabel?.numberOfLines = 0

            HWMetaContainer.write(allergen, forKey: "allergen", in: allergenCell)

            allergensCells.append(allergenCell)
        }

        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateUI()
    }

    func updateUI() {
        self.campusCell.detailTextLabel?.text = self.campusTitles[HWDefault.diningCampus]
        self.filterSwitch.isOn = HWDefault.diningIsFilterOn

        ratingCells.forEach { (ratingCell) in
            guard let rating = HWMetaContainer.retrieve(fromKey: "rating", of: ratingCell) as? CafeteriaDish.Rating else {
                return
            }

            ratingCell.accessoryType = HWDefault.diningFilterRating(for: rating) ? .none : .checkmark
        }

        badgesCells.forEach { (badgeCell) in
            guard let badge = HWMetaContainer.retrieve(fromKey: "badge", of: badgeCell) as? CafeteriaDish.Badge else {
                return
            }

            badgeCell.accessoryType = HWDefault.diningFilterBadge(for: badge) ? .none : .checkmark
        }

        additivesCells.forEach { (additiveCell) in
            guard let additive = HWMetaContainer.retrieve(fromKey: "additive", of: additiveCell) as? CafeteriaDish.Additive else {
                return
            }

            additiveCell.accessoryType = HWDefault.diningFilterAdditive(for: additive) ? .none : .checkmark
        }

        allergensCells.forEach { (allergenCell) in
            guard let allergen = HWMetaContainer.retrieve(fromKey: "allergen", of: allergenCell) as? CafeteriaDish.Allergen else {
                return
            }

            allergenCell.accessoryType = HWDefault.diningFilterAllergen(for: allergen) ? .none : .checkmark
        }

        let merged = ratingCells + badgesCells + additivesCells + allergensCells
        merged.forEach { (cell) in
            disableCell(cell, disable: !self.filterSwitch.isOn)
        }
    }

    private func disableCell(_ cell: UITableViewCell, disable: Bool) {
        cell.isUserInteractionEnabled = !disable
        cell.textLabel?.isEnabled = !disable
        cell.detailTextLabel?.isEnabled = !disable
        cell.tintColor = disable ? HWColors.StyleGuide.secondaryGray : HWColors.StyleGuide.primaryGreen
    }

    @objc func filterSwitchChanged() {
        HWDefault.diningIsFilterOn = self.filterSwitch.isOn

        DiningMasterController.updateOnAppear = true

        let merged = ratingCells + badgesCells + additivesCells + allergensCells
        merged.forEach { (cell) in
            disableCell(cell, disable: !self.filterSwitch.isOn)
        }
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            navigationBar?.shadowImage = UIImage()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return ratingCells.count
        case 3: return badgesCells.count
        case 4: return additivesCells.count
        case 5: return allergensCells.count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section].type

        switch sectionType {
        case .campus:
            return self.campusCell
        case .filter:
            return self.filterCell
        case .rating:
            return ratingCells[indexPath.row]
        case .badges:
            return badgesCells[indexPath.row]
        case .additives:
            return additivesCells[indexPath.row]
        case .allergens:
            return allergensCells[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }

        let sectionType = sections[indexPath.section].type
        switch sectionType {
        case .campus:
            if HWDefault.diningCampus == 0 {
                HWDefault.diningCampus = 1
                self.campusCell.detailTextLabel?.text = self.campusTitles[1]
            } else {
                HWDefault.diningCampus = 0
                self.campusCell.detailTextLabel?.text = self.campusTitles[0]
            }
            DiningMasterController.updateOnAppear = true
        case .filter:
            break
        case .rating:
            guard let rating = HWMetaContainer.retrieve(fromKey: "rating", of: cell) as? CafeteriaDish.Rating else {
                return
            }

            let filtered = HWDefault.diningFilterRating(for: rating)
            HWDefault.diningFilterRating(set: !filtered, for: rating)
            cell.accessoryType = !filtered ? .none : .checkmark
        case .badges:
            guard let badge = HWMetaContainer.retrieve(fromKey: "badge", of: cell) as? CafeteriaDish.Badge else {
                return
            }

            let filtered = HWDefault.diningFilterBadge(for: badge)
            HWDefault.diningFilterBadge(set: !filtered, for: badge)
            cell.accessoryType = !filtered ? .none : .checkmark
        case .additives:
            guard let additive = HWMetaContainer.retrieve(fromKey: "additive", of: cell) as? CafeteriaDish.Additive else {
                return
            }

            let filtered = HWDefault.diningFilterAdditive(for: additive)
            HWDefault.diningFilterAdditive(set: !filtered, for: additive)
            cell.accessoryType = !filtered ? .none : .checkmark
        case .allergens:
            guard let allergen = HWMetaContainer.retrieve(fromKey: "alelrgen", of: cell) as? CafeteriaDish.Allergen else {
                return
            }

            let filtered = HWDefault.diningFilterAllergen(for: allergen)
            HWDefault.diningFilterAllergen(set: !filtered, for: allergen)
            cell.accessoryType = !filtered ? .none : .checkmark
        }
    }
}
