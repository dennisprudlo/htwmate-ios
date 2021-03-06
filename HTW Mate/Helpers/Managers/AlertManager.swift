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

    enum DispatchType {
        case inherit
        case ok
    }

    init(in viewController: UIViewController) {
        self.viewController = viewController
    }

    func insufficentPermission(for permission: AlertManager.PermissionType) -> Void {
        switch permission {
        case .eventStore:
            title = HWStrings.Permissions.eventStore.title
            message = HWStrings.Permissions.eventStore.description
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
        dispatch(ofType: .inherit)
    }
	
	func unlinkAccount() -> Void {
		alertController = UIAlertController(title: HWStrings.Authentication.unlinkTitle, message: HWStrings.Authentication.unlinkConfirmation, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: HWStrings.cancel, style: .cancel, handler: nil))
		alertController.addAction(UIAlertAction(title: HWStrings.unlink, style: .destructive, handler: { (action) in
            
			Keychain.standard.removeObject(forKey: Keychain.Key.authenticationStudentId)
			Keychain.standard.removeObject(forKey: Keychain.Key.authenticationPassword)
			
			self.viewController.navigationController?.popViewController(animated: true)
        }))
        
		viewController.present(alertController, animated: true, completion: nil)
	}

    func with(message: String) -> AlertManager {
        self.message = message
        return self
    }

    func with(title: String) -> AlertManager {
        self.title = title
        return self
    }

    func dispatch(ofType dispatchType: AlertManager.DispatchType = .ok) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        switch dispatchType {
        case .inherit:
            break;
        case .ok:
            alertController.addAction(UIAlertAction(title: HWStrings.ok, style: .default, handler: nil))
        }

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
