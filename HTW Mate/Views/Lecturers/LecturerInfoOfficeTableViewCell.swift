//
//  LecturerInfoOfficeTableViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/11/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LecturerInfoOfficeTableViewCell : LecturerInfoTableViewCell {

    let addressRoomLabel = UILabel()
    let addressThoroughfareLabel = UILabel()
    let addressLocalityLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setupUI(withHeadline headline: String? = nil) {
        super.setupUI(withHeadline: "Office")

        contentView.addSubview(addressRoomLabel)
        contentView.addSubview(addressThoroughfareLabel)
        contentView.addSubview(addressLocalityLabel)

        addressRoomLabel.translatesAutoresizingMaskIntoConstraints = false
        addressRoomLabel.numberOfLines = 1
        addressRoomLabel.topAnchor.constraint(equalTo: super.sectionTopAnchor, constant: super.sectionTitlePadding).isActive = true
        addressRoomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: super.cellPadding).isActive = true
        addressRoomLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -super.cellPadding).isActive = true

        addressThoroughfareLabel.translatesAutoresizingMaskIntoConstraints = false
        addressThoroughfareLabel.numberOfLines = 1
        addressThoroughfareLabel.topAnchor.constraint(equalTo: addressRoomLabel.bottomAnchor).isActive = true
        addressThoroughfareLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: super.cellPadding).isActive = true
        addressThoroughfareLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -super.cellPadding).isActive = true

        addressLocalityLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLocalityLabel.numberOfLines = 1
        addressLocalityLabel.topAnchor.constraint(equalTo: addressThoroughfareLabel.bottomAnchor).isActive = true
        addressLocalityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: super.cellPadding).isActive = true
        addressLocalityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -super.cellPadding).isActive = true
        addressLocalityLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -super.cellPadding).isActive = true
    }

    override func reload() {
        let textData = tableViewController.lecturer.getOfficeAddressText()
        addressRoomLabel.text = textData.room
        addressThoroughfareLabel.text = textData.thoroughfare
        addressLocalityLabel.text = textData.locality
    }

    func openInMaps() {
        let textData = tableViewController.lecturer.getOfficeAddressText()

        let inline = "\(textData.thoroughfare), \(textData.locality)"

        CLGeocoder().geocodeAddressString(inline) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                AlertManager(in: self.tableViewController)
                    .with(title: "Address not found")
                    .with(message: "Unfortunately the address could not be determined")
                    .dispatch()
                return
            }

            let latitude: CLLocationDegrees = location.coordinate.latitude
            let longitude: CLLocationDegrees = location.coordinate.longitude

            let mapLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: mapLocation)
            let mapItem = MKMapItem(placemark: placemark)

            let lecturer = self.tableViewController.lecturer
            mapItem.name = lecturer?.getFullName(withTitle: true)
            mapItem.phoneNumber = lecturer?.phone
            mapItem.url = lecturer?.websiteUrl

            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinateSpan: mapSpan)])
        }
    }
}