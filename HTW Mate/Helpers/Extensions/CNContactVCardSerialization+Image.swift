//
//  CNContactVCardSerialization+Image.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/16/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation
import Contacts

extension CNContactVCardSerialization {

    class func dataWithImage(contacts: [CNContact]) throws -> Data {
        var text: String = ""
        for contact in contacts {
            let data = try CNContactVCardSerialization.data(with: [contact])
            var str = String(data: data, encoding: .utf8)!
            if let imageData = contact.imageData {
                let base64 = imageData.base64EncodedString()
                str = str.replacingOccurrences(of: "END:VCARD", with: "PHOTO;ENCODING=b;TYPE=JPEG:\(base64)\nEND:VCARD")
            }
            text = text.appending(str)
        }
        return text.data(using: .utf8)!
    }

}
