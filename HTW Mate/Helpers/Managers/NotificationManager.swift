//
//  NotificationManager.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 10/24/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class NotificationManager {

	static let shared: NotificationManager = NotificationManager()

	/// The registered notification responses
	var notifications: [UNNotificationResponse] = []

	/// Registers a notification response to handle later on
	/// - Parameter response: the notification response
	func registerResponse(_ response: UNNotificationResponse) -> Void {
		self.notifications.append(response)
	}

	/// Gets the applications current visible window
	func getWindow() -> UIWindow? {
		guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
			return nil
		}

		return scene.windows.first
	}


	/// Retrieves the value for a key in the user info payload
	/// - Parameter key: The key of which the value should be returned
	/// - Parameter userInfo: The user info payload to search in
	func value<T>(forUserInfoKey key: String, in userInfo: [AnyHashable: Any]) -> T? {
		return userInfo[key] as? T
	}

	/// Handles the notificationr responses that were registered
	func handle() -> Void {
		self.notifications.forEach { (response) in
			let request		= response.notification.request
			let identifier	= request.content.categoryIdentifier
			let userInfo	= request.content.userInfo

			handleNotification(request: request, withIdentifier: identifier, userInfo: userInfo)
		}

		//
		// After successful processing clean the registered notifications
		self.notifications = []
	}


	/// Handle a single notification response
	/// - Parameter request: The notifications request
	/// - Parameter identifier: The custom category identifier of the notification
	/// - Parameter userInfo: The added user info payload
	func handleNotification(request: UNNotificationRequest, withIdentifier identifier: String, userInfo: [AnyHashable: Any]) -> Void {
		if identifier == "NOTIFID_ARTICLE_NEW" {
			(self.getWindow()?.rootViewController as? HWTabBarController)?.selectedIndex = 0

			DashboardNewsStorage.shared.reload()

			if let urlString: String = self.value(forUserInfoKey: "url", in: userInfo), let url = URL(string: urlString) {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			}
		}
	}


	/// Tries to registers this device for user notifications
	func registerForPushNotifications() -> Void {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
			//
			// If the user hasn't granted permissions for user notidications
			// the app won't try to updated the device token
			guard granted else {
				return
			}

			self?.getSettings()
		}
	}

	/// Checks if the notification status is authorized and register the application to receive user notifications if so
	func getSettings() -> Void {
		UNUserNotificationCenter.current().getNotificationSettings { settings in
			guard settings.authorizationStatus == .authorized else {
				return
			}

			DispatchQueue.main.async {
				UIApplication.shared.registerForRemoteNotifications()
			}
		}
	}

	/// Refreshes the device token on the htw mate server
	/// - Parameter tokenData: The current device token data
	func refreshDeviceToken(tokenData: Data) -> Void {

		//
		// Generate the hexadecimal device token from the token data
		let tokenParts	= tokenData.map { data in String(format: "%02.2hhx", data) }
		let token		= tokenParts.joined()

		//
		// Obtain the devices current preferred app language
		let locale = Application.locale.original.languageCode ?? "en"

		//
		// Send the device token to the database
		let route = API.shared.route("apns/request", query: false)
		API.shared.post(route: route, params: ["deviceToken": token, "locale": locale]) { (data, response) in

		}
	}

}
