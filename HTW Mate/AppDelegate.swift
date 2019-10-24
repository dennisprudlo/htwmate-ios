//
//  AppDelegate.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		UNUserNotificationCenter.current().delegate = self

        //
        // Update app appearance styles
        AppearanceManager.updateControlsAppearance()

        //
        // Preload app data
        LecturerStorage.shared.reload()
        CafeteriaStorage.shared.reload(forDate: DiningController.getInitialDate())

		//
		// Request notification permissions
		NotificationManager.shared.registerForPushNotifications()

        return true
    }

	// MARK: User Notification Center

	/// Handles the response from the apple push notification service with the current device token
	/// - Parameter application: the ui application instance
	/// - Parameter deviceToken: the deveice token as data
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		NotificationManager.shared.refreshDeviceToken(tokenData: deviceToken)
	}


	/// Handles the receival of a notification response (when tapping a notification)
	/// - Parameter center: The used notification center
	/// - Parameter response: The notification response data
	/// - Parameter completionHandler: The completion handler
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		NotificationManager.shared.registerResponse(response)
		NotificationManager.shared.handle()
		completionHandler()
	}

	/// Handles the presentation of a notification within the application
	/// - Parameter center: the used notification center
	/// - Parameter notification: The notification that will be displayed
	/// - Parameter completionHandler: The completion handler
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		// Display the notification even in the user in inside the application
		// But do not add a bage or play a sound
		completionHandler([.alert])
	}
}

