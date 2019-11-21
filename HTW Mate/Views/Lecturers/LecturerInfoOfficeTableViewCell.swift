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
        super.setupUI(withHeadline: HWStrings.Controllers.Lecturers.Detail.sectionOffice)

        contentView.addSubview(addressRoomLabel)
        contentView.addSubview(addressThoroughfareLabel)
        contentView.addSubview(addressLocalityLabel)

		[addressRoomLabel, addressThoroughfareLabel, addressLocalityLabel].forEach { (label) in
			label.translatesAutoresizingMaskIntoConstraints = false
			label.numberOfLines = 0
			label.font = Font.shared.scaled(textStyle: .body, weight: .regular)
		}
		
        addressRoomLabel.topAnchor.constraint(equalTo: super.sectionTopAnchor, constant: super.sectionTitlePadding).isActive = true
        addressRoomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: super.cellPadding).isActive = true
        addressRoomLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -super.cellPadding).isActive = true

        addressThoroughfareLabel.topAnchor.constraint(equalTo: addressRoomLabel.bottomAnchor).isActive = true
        addressThoroughfareLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: super.cellPadding).isActive = true
        addressThoroughfareLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -super.cellPadding).isActive = true

        addressLocalityLabel.topAnchor.constraint(equalTo: addressThoroughfareLabel.bottomAnchor).isActive = true
        addressLocalityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: super.cellPadding).isActive = true
        addressLocalityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -super.cellPadding).isActive = true
        addressLocalityLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -super.cellPadding).isActive = true
    }

    override func reload() {
        let textData					= tableViewController.lecturer.getOfficeAddressText()
        addressRoomLabel.text			= textData.room
        addressThoroughfareLabel.text	= textData.thoroughfare
        addressLocalityLabel.text		= textData.locality
    }

    func openInMaps() {
        let textData = tableViewController.lecturer.getOfficeAddressText()

        let inline = "\(textData.thoroughfare), \(textData.locality)"

        CLGeocoder().geocodeAddressString(inline) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                return AlertManager(in: self.tableViewController)
                    .with(title: HWStrings.Alerts.addressNotFound.title)
                    .with(message: HWStrings.Alerts.addressNotFound.description)
                    .dispatch()
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
