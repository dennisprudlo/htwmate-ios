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

    static let shared: LecturerStorage = LecturerStorage()

    let sections: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var displayedSections: [String] = []
    var displayedLecturers: [[Lecturer]] = []

    private var lecturers: [Lecturer] = []

    /// Reloads the lecturers from the API and sort the items by the lecturers name
    ///
    /// - Parameter delegate: The delegate reference where the sender should be notified
    func reload(delegate: LecturerStorageDelegate) -> Void {
        API.shared.lecturersResource().get { (lecturers, response) in
            self.lecturers = lecturers.sorted(by: { (first, second) -> Bool in
                let firstCompound = "\(first.lastname)\(first.firstname)"
                let secondCompound = "\(second.lastname)\(second.firstname)"
                return firstCompound < secondCompound
            })

            self.buildDisplayedLecturers()

            DispatchQueue.main.async {
                 delegate.lecturerStorage(didReloadLecturers: self.lecturers)
            }
        }
    }

    private func buildDisplayedLecturers() -> Void {
        displayedLecturers = []
        displayedSections = []

        for index in 0..<sections.count {
            let sectionIdentifier = sections[index]

            let filteredLecturers = self.lecturers.filter { (lecturer) -> Bool in
                return lecturer.lastname.starts(with: sectionIdentifier)
            }

            if filteredLecturers.count > 0 {
                displayedLecturers.append(filteredLecturers)
                displayedSections.append(sectionIdentifier)
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
