//
//  AuthManager.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/1/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class AuthManager {

	static let shared: AuthManager = AuthManager()

	func authenticated() -> Bool {
		return false
	}

	func authenticate(withUsername username: String, password: String, completion: @escaping (Bool) -> Void) -> Void {
		completion(false)
	}

	func presentAuthenticationController(in controller: UIViewController?) -> Void {
		controller?.present(HWAuthenticationController(), animated: true, completion: nil)
	}
}
