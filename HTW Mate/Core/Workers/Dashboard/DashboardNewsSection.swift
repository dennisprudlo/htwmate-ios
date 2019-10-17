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

    override func supplementaryHeader(at indexPath: IndexPath, in collectionView: UICollectionView, presentingController: UIViewController) -> UICollectionReusableView {
        let header = SectionTitleCollectionReusableView.dequeue(from: collectionView, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.setTitle(HWStrings.Controllers.Dashboard.sectionNews)
        header.setDetailTitle(nil)
        return header
    }

    override func itemHeight(at indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
