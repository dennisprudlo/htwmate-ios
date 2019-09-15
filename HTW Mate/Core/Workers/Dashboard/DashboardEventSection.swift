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

    override func supplementaryHeader(at indexPath: IndexPath, in collectionView: UICollectionView, presentingController: UIViewController) -> UICollectionReusableView {
        let header = SectionTitleCollectionReusableView.dequeue(from: collectionView, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.setTitle(HWStrings.Controllers.Dashboard.sectionEvents)
        header.setDetailTitle(HWStrings.Controllers.Dashboard.metaMore)
        header.onDetailTap = { () -> Void in
            presentingController.present(DashboardEventsController(), animated: true, completion: nil)
        }
        return header
    }

    override func itemHeight(at indexPath: IndexPath) -> CGFloat {
        return 83
    }
}
