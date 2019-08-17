//
//  LecturersDetailController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/31/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import Contacts

class LecturersDetailController: UITableViewController {

    var sectionCells: [LecturerInfoTableViewCell.Type] = []

    var lecturer: Lecturer! {
        didSet {
            rebuildUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true

        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActionButton(_:)))

        tableView.register(LecturerInfoHeadTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoHeadTableViewCell.self))
        tableView.register(LecturerInfoOfficeTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoOfficeTableViewCell.self))
        tableView.register(LecturerInfoUpdatedTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoUpdatedTableViewCell.self))
        tableView.register(LecturerInfoFieldOfWorkTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoFieldOfWorkTableViewCell.self))
        tableView.register(LecturerInfoMainAreaTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoMainAreaTableViewCell.self))
        tableView.register(LecturerInfoResearchActivitiesTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoResearchActivitiesTableViewCell.self))
        tableView.register(LecturerInfoOfficialCapacityTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoOfficialCapacityTableViewCell.self))
        tableView.register(LecturerInfoOfficeHoursTableViewCell.self, forCellReuseIdentifier: String(describing: LecturerInfoOfficeHoursTableViewCell.self))

        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200

        #warning("Dirty solution for the bottom inset bug in the table view")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -83, right: 0)
    }

    func rebuildUI() -> Void {
        self.title = lecturer.lastname

        sectionCells = lecturer.getInfoCellTypes()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: sectionCells[indexPath.row].self)) as? LecturerInfoTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }

        cell.tableViewController = self
        cell.reload()
        cell.layoutSubviews()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LecturerInfoOfficeTableViewCell {
            cell.openInMaps()
        }
    }

    @objc func didTapActionButton(_ sender: UIBarButtonItem) {

        let contact = lecturer.createContact()
        do {
            try shareContactWithThirdParty(contact)
        } catch{
            LogManager(ofType: .error).put("Contact could not be creatd.").from(contact)
        }
    }

    func shareContactWithThirdParty(_ contact: CNContact) throws {
        guard let directoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }

        var filename = UUID().uuidString

        if let fullname = CNContactFormatter().string(from: contact) {
            filename = fullname.components(separatedBy: " ").joined(separator: "")
        }

        let fileUrl = directoryUrl.appendingPathComponent(filename).appendingPathExtension("vcf")

        let data = try CNContactVCardSerialization.dataWithImage(contacts: [contact])
        try data.write(to: fileUrl, options: Data.WritingOptions.atomicWrite)

        let activityViewController = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
