//
//  HWStrings.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/13/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation

typealias TitleDescriptionPair = (title: String, description: String)

struct HWStrings {

    // MARK: Default Navigation
    static let yes = NSLocalizedString("base.yes", comment: "The title for a button which agrees with the situation")
    static let no = NSLocalizedString("base.no", comment: "The title for a button which disagrees with the situation")
    static let ok = NSLocalizedString("base.ok", comment: "The title for a button which just represents and 'ok'")
    static let cancel = NSLocalizedString("base.cancel", comment: "The title for a button which cancels the operation")
    static let settings = NSLocalizedString("base.settings", comment: "The title for a button which navigates to the settings of the application")

    // MARK: Permission alerts
    struct Permissions {
        static let eventStore: TitleDescriptionPair = (
            title: NSLocalizedString("permission.eventstore.title", comment: "The title for the information that the calendar settings were denied"),
            description: NSLocalizedString("permission.eventstore.description", comment: "The information that the user can change the calendar permissions in the settings")
        )
    }

    struct Alerts {
        static let missingMailAccount: TitleDescriptionPair = (
            title: NSLocalizedString("alert.missingmailaccount.title", comment: "The title for the information that the user has no mail account configured"),
            description: NSLocalizedString("alert.missingmailaccount.description", comment: "The information that the user can configure a mail account in the settings")
        )
        static let addressNotFound: TitleDescriptionPair = (
            title: NSLocalizedString("alert.addressnotfound.title", comment: "The title for the information that the passed address could not be found on the map"),
            description: NSLocalizedString("alert.addressnotfound.description", comment: "The description for the information that the passed address could not be found on the map")
        )
    }

    struct Controllers {
        struct Dashboard {
            static let title = NSLocalizedString("controller.dashboard.title", comment: "The title for the main dashboard view, usually being 'HTW'")
            static let metaMore = NSLocalizedString("controller.dashboard.meta.more", comment: "The title for the label which shows the user a view with more of the content he sees right now")
            static let sectionNews = NSLocalizedString("controller.dashboard.section.news", comment: "The title for the top news section, where some news are listed")
            static let sectionEvents = NSLocalizedString("controller.dashboard.section.events", comment: "The title for the events section, where some events are listed")
        }
        struct Lecturers {
            static let title = NSLocalizedString("controller.lecturer.title", comment: "The title for the view where the lecturers will be displayed")
            static let searchBarTitle = NSLocalizedString("controller.lecturer.searchbartitle", comment: "The placeholder string for the lecturers search bar")
            struct Detail {
                static let mail = NSLocalizedString("controller.lecturer.detail.mail", comment: "The text description for the 'send mail' quick action")
                static let call = NSLocalizedString("controller.lecturer.detail.call", comment: "The text description for the 'call' quick action")
                static let visit = NSLocalizedString("controller.lecturer.detail.visit", comment: "The text description for the 'visit web' quick action")

                static let sectionOffice = NSLocalizedString("controller.lecturer.detail.section.office", comment: "The section headline for the office data")
                static let sectionOfficeHours = NSLocalizedString("controller.lecturer.detail.section.officehours", comment: "The section headline for the office hours data")
                static let sectionFieldOfWork = NSLocalizedString("controller.lecturer.detail.section.fieldofwork", comment: "The section headline for the field of work data")
                static let sectionMainArea = NSLocalizedString("controller.lecturer.detail.section.mainarea", comment: "The section headline for the main area data")
                static let sectionResearchActivities = NSLocalizedString("controller.lecturer.detail.section.researchactivities", comment: "The section headline for the research activity data")
                static let sectionOfficialCapacity = NSLocalizedString("controller.lecturer.detail.section.officialcapacity", comment: "The section headline for the official capacity data")

                static let lastUpdate = NSLocalizedString("controller.lecturer.detail.lastupdate", comment: "The formatted string for the information when the lecturer was last updated")
                static let lastUpdateDateFormat = NSLocalizedString("controller.lecturer.detail.lastupdate.dateformat", comment: "The NSDateFormatters date format for the current locale")
            }
        }
    }
}
