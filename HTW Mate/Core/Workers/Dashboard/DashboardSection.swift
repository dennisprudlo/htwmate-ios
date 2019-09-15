//
//  DashboardSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/15/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardSection {

    func numberOfItems() -> Int {
        return 0
    }

    func itemsPerRow(forSize size: CGSize) -> Int {
        if size.width <= 414.0 {
            return 1
        } else if size.width < 1000.0 {
            return 2
        } else {
            return 3
        }
    }

    func itemHeight(at indexPath: IndexPath) -> CGFloat {
        return 0
    }

    func sectionInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: HWInsets.standard, left: HWInsets.standard, bottom: HWInsets.standard, right: HWInsets.standard)
    }

    func supplementaryHeaderHeight() -> CGFloat {
        return 40
    }

    func supplementaryHeader(at indexPath: IndexPath, in collectionView: UICollectionView, presentingController: UIViewController) -> UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SectionTitleCollectionReusableView.self), for: indexPath)
    }
}
