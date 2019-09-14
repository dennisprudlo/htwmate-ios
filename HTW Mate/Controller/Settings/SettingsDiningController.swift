//
//  SettingsDiningController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/14/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class SettingsDiningController: UITableViewController {

    enum SectionType {
        case campus
        case filter
    }

    let sections: [(type: SectionType, header: String?, footer: String?)] = [
        (type: .campus, header: nil, footer: "Select the campus where you are primarily eating lunch at."),
        (type: .filter, header: nil, footer: nil)
    ]

    let campusCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
    let filterCell = UITableViewCell(style: .default, reuseIdentifier: nil)
    let filterSwitch = UISwitch()

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
        self.campusCell.textLabel?.text = "Campus"
        self.campusCell.detailTextLabel?.text = self.campusTitles[HWDefault.diningCampus]

        self.filterCell.textLabel?.text = "Filter"
        self.filterCell.selectionStyle = .none
        self.filterCell.accessoryView = self.filterSwitch

        self.filterSwitch.isOn = HWDefault.diningIsFilterOn
        self.filterSwitch.addTarget(self, action: #selector(filterSwitchChanged), for: .valueChanged)
    }

    @objc func filterSwitchChanged(_ sender: UISwitch) {
        HWDefault.diningIsFilterOn = !HWDefault.diningIsFilterOn
        self.filterSwitch.setOn(HWDefault.diningIsFilterOn, animated: true)
        DiningMasterController.updateOnAppear = true
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
        return 1
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
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

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
            break;
        }
    }
}
