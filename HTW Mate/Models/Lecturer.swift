//
//  Lecturer.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import Contacts

class Lecturer : DatabaseModel {

    var htwId: Int
    var title: String?
    var lastname: String
    var tableViewSectionLetter: String = ""
    var tableViewSectionHaystack: String = ""
    var firstname: String
    var mail: String?
    var mobile: String?
    var phone: String?
    var fax: String?
    var websiteUrl: URL?
    var imageUrl: URL?
    var image: UIImage? = HWImage.lecturersProfilePlaceholder
    var imageSet: Bool = false
    var officeCampus: String?
    var officeBuilding: String?
    var officeRoom: String?
    var officeThoroughfare: String?
    var officePostalCode: String?
    var officeLocality: String?
    var fieldOfWork = HWLecturerRenderer()
    var mainArea = HWLecturerRenderer()
    var researchActivities = HWLecturerRenderer()
    var officialCapacity = HWLecturerRenderer()
    var officeHours = HWLecturerRenderer()
    var lastUpdatedAt: Date?

    private var quickActionSubviews: [UIView] = []

    init(databaseId: Int, htwId: Int, lastname: String, firstname: String) {
        self.htwId = htwId
        self.lastname = lastname
        self.firstname = firstname
        super.init(databaseId: databaseId)
    }

    public static func from(json dictionary: NSDictionary) -> Lecturer {
        let databaseId = dictionary.value(forKey: "id") as? Int ?? 0
        let htwId = dictionary.value(forKey: "htw_id") as? Int ?? 0
        let lastname = dictionary.value(forKey: "lastname") as? String ?? "Unnamed"
        let firstname = dictionary.value(forKey: "firstname") as? String ?? "Unnamed"

        let lecturer = Lecturer(databaseId: databaseId, htwId: htwId, lastname: lastname, firstname: firstname)

        lecturer.title = dictionary.value(forKey: "title") as? String
        lecturer.mail = dictionary.value(forKey: "mail") as? String
        lecturer.mobile = dictionary.value(forKey: "mobile") as? String
        lecturer.phone = dictionary.value(forKey: "phone") as? String
        lecturer.fax = dictionary.value(forKey: "fax") as? String

        let websiteUrl = dictionary.value(forKey: "website_url") as? String ?? ""
        lecturer.websiteUrl = URL(string: websiteUrl)

        let imageUrl = dictionary.value(forKey: "image_url") as? String ?? ""
        lecturer.imageUrl = URL(string: imageUrl)

        lecturer.officeCampus = dictionary.value(forKey: "office_campus") as? String
        lecturer.officeBuilding = dictionary.value(forKey: "office_building") as? String
        lecturer.officeRoom = dictionary.value(forKey: "office_room") as? String
        lecturer.officeThoroughfare = dictionary.value(forKey: "office_thoroughfare") as? String
        lecturer.officePostalCode = dictionary.value(forKey: "office_postal_code") as? String
        lecturer.officeLocality = dictionary.value(forKey: "office_locality") as? String

        // Load renderer json representation
        lecturer.fieldOfWork.data = dictionary.value(forKey: "field_of_work") as? String ?? "[]"
        lecturer.mainArea.data = dictionary.value(forKey: "main_area") as? String ?? "[]"
        lecturer.researchActivities.data = dictionary.value(forKey: "research_activities") as? String ?? "[]"
        lecturer.officialCapacity.data = dictionary.value(forKey: "official_capacity") as? String ?? "[]"
        lecturer.officeHours.data = dictionary.value(forKey: "office_hours") as? String ?? "[]"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let lastUpdatedAtString = dictionary.value(forKey: "updated_at") as? String ?? ""
        lecturer.lastUpdatedAt = dateFormatter.date(from: lastUpdatedAtString)

        lecturer.tableViewSectionHaystack = "\(lecturer.title ?? "") \(lecturer.firstname) \(lecturer.lastname)".lowercased()
        lecturer.tableViewSectionLetter = String(lastname.first ?? Character(""))

        return lecturer
    }

    public func downloadImage(completion: ((UIImage?) -> Void)? = nil) -> Void {
        guard let url = self.imageUrl else {
            return
        }

        //
        // Download the lecturers image and display it
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.imageSet = true
                if let handler = completion {
                    handler(self.image)
                }
            }
        }
        task.resume()
    }

    public func getInfoCellTypes() -> [LecturerInfoTableViewCell.Type] {
        var output: [LecturerInfoTableViewCell.Type] = [LecturerInfoHeadTableViewCell.self]

        if self.hasOffice() {
            output.append(LecturerInfoOfficeTableViewCell.self)
        }

        if officeHours.hasContent() {
            officeHours.compose()
            output.append(LecturerInfoOfficeHoursTableViewCell.self)
        }

        if fieldOfWork.hasContent() {
            fieldOfWork.compose()
            output.append(LecturerInfoFieldOfWorkTableViewCell.self)
        }

        if mainArea.hasContent() {
            mainArea.compose()
            output.append(LecturerInfoMainAreaTableViewCell.self)
        }

        if researchActivities.hasContent() {
            researchActivities.compose()
            output.append(LecturerInfoResearchActivitiesTableViewCell.self)
        }

        if officialCapacity.hasContent() {
            officialCapacity.compose()
            output.append(LecturerInfoOfficialCapacityTableViewCell.self)
        }

        output.append(LecturerInfoUpdatedTableViewCell.self)

        return output
    }

    public func getFullName(withTitle: Bool = false) -> String {
        return "\(withTitle && self.title != nil ? "\(self.title ?? "") " : "")\(self.firstname) \(self.lastname)"
    }

    public func hasMail() -> Bool {
        return self.mail != nil
    }

    public func hasMobileOrPhone() -> Bool {
        return self.mobile != nil || self.phone != nil
    }

    public func hasPhone() -> Bool {
        return self.phone != nil
    }

    public func hasMobile() -> Bool {
        return self.mobile != nil
    }

    public func hasWebsite() -> Bool {
        return self.websiteUrl != nil
    }

    public func hasOffice() -> Bool {
        let hasRoom = self.officeCampus != nil && self.officeBuilding != nil && self.officeRoom != nil
        let hasAddress = self.officeThoroughfare != nil && self.officePostalCode != nil && self.officeLocality != nil

        return hasRoom || hasAddress
    }

    public func getOfficeAddressText() -> (room: String, thoroughfare: String, locality: String) {
        var room: String = ""
        var thoroughfare: String = ""
        var locality: String = ""

        if let officeBuilding = self.officeBuilding, let officeRoom = self.officeRoom {
            room = "\(officeBuilding), \(officeRoom)"
        }

        if let officeThoroughfare = self.officeThoroughfare {
            thoroughfare = officeThoroughfare
        }

        if let officePostalCode = self.officePostalCode, let officeLocality = self.officeLocality {
            locality = "\(officePostalCode) \(officeLocality)"
        }

        return (room: room, thoroughfare: thoroughfare, locality: locality)
    }
    
    public func getQuickActionSubviews() -> [UIView] {
        guard quickActionSubviews.count == 0 else {
            return quickActionSubviews
        }

        quickActionSubviews.append(self.generateQuickActionSubview(withTitle: HWStrings.Controllers.Lecturers.Detail.mail,   icon: HWIcons.lecturersQuickActionMessage,  active: self.hasMail()))
        quickActionSubviews.append(self.generateQuickActionSubview(withTitle: HWStrings.Controllers.Lecturers.Detail.call,   icon: HWIcons.lecturersQuickActionPhone,    active: self.hasMobileOrPhone()))
        quickActionSubviews.append(self.generateQuickActionSubview(withTitle: HWStrings.Controllers.Lecturers.Detail.visit,  icon: HWIcons.lecturersQuickActionWebsite,  active: self.hasWebsite()))

        return quickActionSubviews
    }

    private func generateQuickActionSubview(withTitle title: String, icon: UIImage?, active: Bool) -> UIStackView {
        let bubbleSize: CGFloat = 48

        let actionView = UIView()
        actionView.translatesAutoresizingMaskIntoConstraints = false
        actionView.heightAnchor.constraint(equalToConstant: bubbleSize
            ).isActive = true
        actionView.heightAnchor.constraint(equalTo: actionView.widthAnchor).isActive = true
        actionView.backgroundColor = active ? HWColors.StyleGuide.primaryGreen : .groupTableViewBackground
        actionView.layer.cornerRadius = bubbleSize / 2

        let iconView = UIImageView(image: icon)
        actionView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleToFill
        iconView.centerXAnchor.constraint(equalTo: actionView.centerXAnchor).isActive = true
        iconView.centerYAnchor.constraint(equalTo: actionView.centerYAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: bubbleSize / 1.6).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
        iconView.tintColor = active ? .white : .lightGray

        let actionLabel = UILabel()
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionLabel.text = title
        actionLabel.font = UIFont.systemFont(ofSize: HWFontSize.metaInfo, weight: .medium)
        actionLabel.textColor = active ? HWColors.StyleGuide.primaryGreen : .lightGray
        actionLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [actionView, actionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical

        return stack
    }

    /// Creates a CNContact instance of the lecturer to use it throughout the application
    ///
    /// - Returns: A CNContact instance with the lecturers contact information
    func createContact() -> CNContact {
        let contact = CNMutableContact()

        if let strongTitle = self.title {
            contact.jobTitle = strongTitle
        }
        contact.familyName = self.lastname
        contact.givenName = self.firstname

        if let strongMail = self.mail as NSString? {
            let mail = CNLabeledValue(label: CNLabelWork, value: strongMail)
            contact.emailAddresses = [mail]
        }

        var phoneNumbers: [CNLabeledValue<CNPhoneNumber>] = []

        if let strongMobile = self.mobile {
            let mobile = CNLabeledValue<CNPhoneNumber>(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: strongMobile))
            phoneNumbers.append(mobile)
        }

        if let strongPhone = self.phone {
            let phone = CNLabeledValue<CNPhoneNumber>(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: strongPhone))
            phoneNumbers.append(phone)
        }

        if let strongFax = self.fax {
            let fax = CNLabeledValue<CNPhoneNumber>(label: CNLabelPhoneNumberWorkFax, value: CNPhoneNumber(stringValue: strongFax))
            phoneNumbers.append(fax)
        }

        contact.phoneNumbers = phoneNumbers

        if let websiteUrl = self.websiteUrl?.absoluteString as NSString? {
            contact.urlAddresses.append(CNLabeledValue<NSString>(label: CNLabelWork, value: websiteUrl))
        }

        if self.hasOffice() {
            let postalAddress = CNMutablePostalAddress()
            if let thoroughfare = self.officeThoroughfare {
                postalAddress.street = thoroughfare
            }
            if let postalCode = self.officePostalCode {
                postalAddress.postalCode = postalCode
            }
            if let locality = self.officeLocality {
                postalAddress.city = locality
            }

            let postalAddressData = CNLabeledValue<CNPostalAddress>(label: CNLabelWork, value: postalAddress)
            contact.postalAddresses.append(postalAddressData)
        }

        if self.imageSet, let image = self.image {
            contact.imageData = image.jpegData(compressionQuality: 1.0)
        }

        contact.contactType = .person
        contact.organizationName = "HTW Berlin"

        return contact
    }
}
