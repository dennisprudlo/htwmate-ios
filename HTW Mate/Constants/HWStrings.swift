//
//  HWStrings.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

struct HWStrings {

    // MARK: Default Navigation
    static let yes = NSLocalizedString("Yes", comment: "The title for a button which agrees with the situation")
    static let no = NSLocalizedString("No", comment: "The title for a button which disagrees with the situation")
    static let cancel = NSLocalizedString("Cancel", comment: "The title for a button which cancels the operation")
    static let settings = NSLocalizedString("Settings", comment: "The title for a button which navigates to the settings of the application")

    static let dashboardItemsMore = NSLocalizedString("more", comment: "The title for the label which shows the user a view with more of the content he sees right now")
    static let dashboardItemsTopNews = NSLocalizedString("Top-News", comment: "The title for the top news section, where some news are listed")
    static let dashboardItemsEvents = NSLocalizedString("Events", comment: "The title for the events section, where some events are listed")

    // MARK: Permission alerts
    static let permissionEventStoreTitle = NSLocalizedString("Denied calendar permissions", comment: "The title for the information that the calendar settings were denied")
    static let permissionEventStoreMessage = NSLocalizedString("Unfortunately we have no permissions to access your calendar. You can change that in the apps settings", comment: "The information that the user can change the calendar permissions in the settings")
}
