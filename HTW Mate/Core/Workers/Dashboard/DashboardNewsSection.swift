//
//  DashboardNewsSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/15/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardNewsSection: DashboardSection {

    override func numberOfItems() -> Int {
        return DashboardNewsStorage.shared.news.count
    }
	
	override func tableViewCell(forItemAt index: IndexPath) -> UITableViewCell {
		let cell = NewsItemTableViewCell()
		
		let article = DashboardNewsStorage.shared.model(for: index)
		cell.setModel(article)
		
		return cell
	}
	
	override func viewForHeaderInSection() -> UIView {
		return DashboardSectionHeaderView(title: HWStrings.Controllers.Dashboard.sectionNews)
    }
}
