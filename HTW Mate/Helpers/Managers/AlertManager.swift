//
//  AlertManager.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/20/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class AlertManager {

    var viewController: UIViewController
    var title: String?
    var message: String?
    var alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    var completionHandler: (() -> Void)?

    enum PermissionType {
        case eventStore
    }

    init(in viewController: UIViewController) {
        self.viewController = viewController
    }

    func insufficentPermission(for permission: AlertManager.PermissionType) -> Void {
        switch permission {
        case .eventStore:
            title = HWStrings.permissionEventStoreTitle
            message = HWStrings.permissionEventStoreMessage
        }

        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: HWStrings.cancel, style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: HWStrings.settings, style: .default, handler: { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }))
        dispatch()
    }

    func dispatch() {

        //
        // Present the alert to the user
        viewController.present(alertController, animated: true, completion: completionHandler)

        //
        // Reset the alert specific data
        title = nil
        message = nil
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    }

}
