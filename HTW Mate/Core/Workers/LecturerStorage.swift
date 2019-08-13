//
//  LecturerStorage.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/31/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

protocol LecturerStorageDelegate {
    func lecturerStorage(didReloadLecturers lecturers: [Lecturer])
}

class LecturerStorage {

    enum FilterScope {
        case all
    }

    static let shared: LecturerStorage = LecturerStorage()

    let sections: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var displayedSections: [String] = []
    var displayedLecturers: [[Lecturer]] = []

    var lastSearchText: String = ""
    var filterScope = LecturerStorage.FilterScope.all

    private var lecturers: [Lecturer] = []

    var delegate: LecturerStorageDelegate?

    /// Reloads the lecturers from the API and sort the items by the lecturers name
    ///
    /// - Parameter delegate: The delegate reference where the sender should be notified
    func reload() -> Void {
        API.shared.lecturersResource().get { (lecturers, response) in
            self.lecturers = lecturers.sorted(by: { (first, second) -> Bool in
                let firstCompound = "\(first.lastname)\(first.firstname)"
                let secondCompound = "\(second.lastname)\(second.firstname)"
                return firstCompound < secondCompound
            })

            self.buildDisplayedLecturers()
        }
    }

    func buildDisplayedLecturers(searchText: String? = nil) -> Void {
        displayedLecturers = []
        displayedSections = []

        let lowerCasedSearchText = searchText?.lowercased() ?? ""

        for index in 0..<sections.count {
            let sectionIdentifier = sections[index]

            let filteredLecturers = self.lecturers.filter { (lecturer) -> Bool in
                let startsWithValidated = sectionIdentifier == lecturer.tableViewSectionLetter

                var searchValidated = true
                if !lowerCasedSearchText.isEmpty {
                    let haystack = lecturer.tableViewSectionHaystack
                    if !haystack.contains(lowerCasedSearchText) {
                        searchValidated = false
                    }
                }

                return startsWithValidated && searchValidated
            }

            if filteredLecturers.count > 0 {
                displayedLecturers.append(filteredLecturers)
                displayedSections.append(sectionIdentifier)
            }
        }

        if delegate != nil {
            DispatchQueue.main.async {
                self.delegate!.lecturerStorage(didReloadLecturers: self.lecturers)
            }
        }
    }

    func titleForSection(_ section: Int) -> String? {
        guard section >= 0 && section < displayedSections.count else {
            return nil
        }
        return displayedSections[section]
    }

    func lecturers(inSection section: Int) -> [Lecturer] {
        guard section >= 0 && section < displayedLecturers.count else {
            return []
        }

        return displayedLecturers[section]
    }
}
