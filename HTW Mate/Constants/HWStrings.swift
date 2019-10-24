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

	public static func localized(_ key: String) -> String {
		return NSLocalizedString(key, comment: "")
	}

    // MARK: Default Navigation
	static let yes		= HWStrings.localized("base.yes")
    static let no		= HWStrings.localized("base.no")
    static let ok		= HWStrings.localized("base.ok")
    static let cancel	= HWStrings.localized("base.cancel")
    static let settings	= HWStrings.localized("base.settings")

    // MARK: Permission alerts
    struct Permissions {
        static let eventStore: TitleDescriptionPair = (
            title:			HWStrings.localized("permission.eventstore.title"),
            description:	HWStrings.localized("permission.eventstore.description")
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
			static let newsFeatured = NSLocalizedString("controller.dashboard.news.featured", comment: "The display text for featured articles")
        }
        struct Lecturers {
            static let title = NSLocalizedString("controller.lecturer.title", comment: "The title for the view where the lecturers will be displayed")
            static let searchBarTitle = NSLocalizedString("controller.lecturer.searchbartitle", comment: "The placeholder string for the lecturers search bar")
			static let missingContentTitle = NSLocalizedString("controller.lecturer.missingcontent.title", comment: "The text for the missing content title in the lecturer view")
            static let missingContentSubtitle = NSLocalizedString("controller.lecturer.missingcontent.subtitle", comment: "The text for the missing content subtitle in the lecturer view")
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
        struct Dining {
            static let title = NSLocalizedString("controller.dining.title", comment: "The title for the main dining view")
            static let todayLabel = NSLocalizedString("controller.dining.todaylabel", comment: "The label for the button to display the menu of today")
            static let pricesFree = NSLocalizedString("controller.dining.prices.free", comment: "The text for the prices label of a dish when its free")
            static let missingContentTitle = NSLocalizedString("controller.dining.missingcontent.title", comment: "The text for the missing content title in the dining view")
            static let missingContentSubtitle = NSLocalizedString("controller.dining.missingcontent.subtitle", comment: "The text for the missing content subtitle in the dining view")
            static let sectionTitleRating = NSLocalizedString("controller.dining.sectiontitle.rating", comment: "The section title for the rating in the dish detail view")
            static let sectionTitleBadge = NSLocalizedString("controller.dining.sectiontitle.badge", comment: "The section title for the badges in the dish detail view")
            static let sectionTitleAdditive = NSLocalizedString("controller.dining.sectiontitle.additive", comment: "The section title for the additives in the dish detail view")
            static let sectionTitleAllergen = NSLocalizedString("controller.dining.sectiontitle.allergen", comment: "The section title for the allergens in the dish detail view")
            static let weekMenuTitle = NSLocalizedString("controller.dining.weekmenutitle", comment: "The title for the pdf view that shows the menu for the current week")
			static let currentDateFormat = NSLocalizedString("controller.dining.currentdateformat", comment: "The format for the current date display in the dining controller")
            struct Categories {
                static let appetizer = NSLocalizedString("controller.dining.categories.appetizer", comment: "The title for the cafeteria menu category for the appetizers")
                static let salad = NSLocalizedString("controller.dining.categories.salad", comment: "The title for the cafeteria menu category for the salads")
                static let soup = NSLocalizedString("controller.dining.categories.soup", comment: "The title for the cafeteria menu category for the soups")
                static let special = NSLocalizedString("controller.dining.categories.special", comment: "The title for the cafeteria menu category for the specials")
                static let main = NSLocalizedString("controller.dining.categories.main", comment: "The title for the cafeteria menu category for the main dishes")
                static let side = NSLocalizedString("controller.dining.categories.side", comment: "The title for the cafeteria menu category for the side dishes")
                static let dessert = NSLocalizedString("controller.dining.categories.dessert", comment: "The title for the cafeteria menu category for the desserts")
            }
            struct Badges {
                static let vegan = NSLocalizedString("controller.dining.badges.vegan", comment: "The badge description for vegan dishes")
                static let climateFriendly = NSLocalizedString("controller.dining.badges.climatefriendly", comment: "The badge description for climate friendly dishes")
                static let vegetarian = NSLocalizedString("controller.dining.badges.vegetarian", comment: "The badge description for vegetarian dishes")
                static let sustainable = NSLocalizedString("controller.dining.badges.sustainable", comment: "The badge description for sustainable dishes")
                static let sustainableFish = NSLocalizedString("controller.dining.badges.sustainablefish", comment: "The badge description for sustainable fish dishes")
            }
            struct Ratings {
                static let greenLeading = NSLocalizedString("controller.dining.ratings.green.leading", comment: "The leading part for the description of green rated dishes")
                static let greenTrailing = NSLocalizedString("controller.dining.ratings.green.trailing", comment: "The trailing part for the description of green rated dishes")
                static let orangeLeading = NSLocalizedString("controller.dining.ratings.orange.leading", comment: "The leading part for the description of orange rated dishes")
                static let orangeTrailing = NSLocalizedString("controller.dining.ratings.orange.trailing", comment: "The trailing part for the description of orange rated dishes")
                static let redLeading = NSLocalizedString("controller.dining.ratings.red.leading", comment: "The leading part for the description of red rated dishes")
                static let redTrailing = NSLocalizedString("controller.dining.ratings.red.trailing", comment: "The trailing part for the description of red rated dishes")
                static let undefinedLeading = NSLocalizedString("controller.dining.ratings.undefined.leading", comment: "The leading part for the description of undefined rated dishes")
                static let undefinedTrailing = NSLocalizedString("controller.dining.ratings.undefined.trailing", comment: "The trailing part for the description of undefined rated dishes")
            }
        }
        struct Settings {
            static let title		= NSLocalizedString("controller.settings.title", comment: "The title for the main settings controller")
            static let itemAbout	= NSLocalizedString("controller.settings.item.about", comment: "The title for the about item")
            static let itemLegal	= NSLocalizedString("controller.settings.item.legal", comment: "The title for the legal item")
            struct Dining {
                static let campus				= NSLocalizedString("controller.settings.dining.campus", comment: "The title for the campus selection setting")
                static let campusDescription	= NSLocalizedString("controller.settings.dining.campus.description", comment: "The description for the campus selection setting")
                static let filter				= NSLocalizedString("controller.settings.dining.filter", comment: "The title for the dining filter setting")
            }
			struct Legal {
				static let title			= NSLocalizedString("controller.settings.legal.title", comment: "The title for the legal section in the settings menu")
				static let privacyPolicy	= NSLocalizedString("controller.settings.legal.privacypolicy", comment: "The title for the privacy policy link")
				static let masthead			= NSLocalizedString("controller.settings.legal.masthead", comment: "The title for the masthead link")
				static let termsOfUse		= NSLocalizedString("controller.settings.legal.termsofuse", comment: "The title for the terms of use link")
				static let support			= NSLocalizedString("controller.settings.legal.support", comment: "The title for the support link")
			}
        }
		struct Studies {
			static let title = HWStrings.localized("controller.studies.title")
			struct Lectures {
				static let title = HWStrings.localized("controller.studies.lectures.title")
				struct Cancelled {
					static let title	= HWStrings.localized("controller.studies.lectures.cancelled.title")
					static let comment	= HWStrings.localized("controller.studies.lectures.cancelled.comment")
				}
			}
			struct HtwServices {
				static let title				= HWStrings.localized("controller.studies.htwservices.title")
				static let universityLibrary	= HWStrings.localized("controller.studies.htwservices.universitylibrary")
				static let mediaLibrary			= HWStrings.localized("controller.studies.htwservices.medialibrary")
			}
		}
    }
}
