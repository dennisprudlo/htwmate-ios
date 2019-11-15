//
//  DashboardEventSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/15/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardEventSection: DashboardSection {

    override func numberOfItems() -> Int {
        return DashboardEventStorage.shared.events.count
    }
	
	override func tableViewCell(forItemAt index: IndexPath) -> UITableViewCell {
		let cell = EventItemTableViewCell()
		
		let event = DashboardEventStorage.shared.model(for: index)
		cell.viewController = presenter
		cell.setModel(event)
		
		return cell
	}
	
	override func titleForHeaderInSection() -> String? {
		return HWStrings.Controllers.Dashboard.sectionEvents
	}
}
