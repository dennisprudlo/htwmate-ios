//
//  DashboardSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/15/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardSection {

	let presenter: UIViewController
	
	init(presenter: UIViewController) {
		self.presenter = presenter
	}
	
    func numberOfItems() -> Int {
        return 0
    }
	
	func tableViewCell(forItemAt index: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func titleForHeaderInSection() -> String? {
		return nil
	}

    func supplementaryHeader(at indexPath: IndexPath, in collectionView: UICollectionView, presentingController: UIViewController) -> UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SectionTitleCollectionReusableView.self), for: indexPath)
    }
}
