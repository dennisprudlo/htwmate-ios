//
//  Lecturer.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/21/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class Lecturer : DatabaseModel {

    var htwId: Int
    var title: String?
    var lastname: String
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

        lecturer.downloadImage()

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

}