//
//  DashboardSettingsSection.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 9/15/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardSettingsSection: DashboardSection {

    override func supplementaryHeader(at indexPath: IndexPath, in collectionView: UICollectionView, presentingController: UIViewController) -> UICollectionReusableView {
        let header = SectionSettingsCollectionReusableView.dequeue(from: collectionView, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        header.viewController = presentingController
        return header
    }

    override func sectionInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: HWInsets.standard, bottom: 0, right: HWInsets.standard)
    }
}
