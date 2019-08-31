//
//  ViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {

    private var itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: HWInsets.standard, left: HWInsets.standard, bottom: HWInsets.standard, right: HWInsets.standard)

    let sectionTypes: [SectionTitleCollectionReusableView.SectionType] = [.topNews, .events]

    /// The refresh control to easily update the displayed date
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = HWStrings.Controllers.Dashboard.title

        self.setStatusBarOverlay()

        //
        // Add the refresh control to the collection view. In case of a iOS 9 system or even older system
        // add the refresh control as a subview. UIKit will automatically know what to do with it
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }

        refreshControl.addTarget(self, action: #selector(didRefreshCollectionView(_:)), for: .valueChanged)

        DashboardNewsStorage.shared.delegate = self
        DashboardNewsStorage.shared.reload()

        DashboardEventStorage.shared.delegate = self
        DashboardEventStorage.shared.reload()

        //
        // Register cells
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: NewsCollectionViewCell.self))
        collectionView.register(SectionTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SectionTitleCollectionReusableView.self))

        //
        // Adjust safe area insets for header and footer views
        collectionView.contentInsetAdjustmentBehavior = .always

        collectionView.backgroundColor = HWColors.contentBackground

        //
        // Set the flow layout to consider the safe area
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInsetReference = .fromSafeArea
        }

        //
        // Calculate the items per row on view load
        calculateItemsPerRow(forSize: view.frame.size)
    }

    public func checkCollectionViewReload() -> Void {
        if DashboardNewsStorage.shared.loaded && DashboardEventStorage.shared.loaded {
            refreshControl.endRefreshing()
            collectionView.reloadData()
        }
    }

    @objc private func didRefreshCollectionView(_ sender: Any) {
        DashboardNewsStorage.shared.reload()
        DashboardEventStorage.shared.reload()
    }

    /// Calculates the items per row in the collection view
    ///
    /// - Parameter size: The size to use for the calculation
    func calculateItemsPerRow(forSize size: CGSize) {
        if size.width <= 375.0 {
            self.itemsPerRow = 1
        } else if size.width < 1000.0 {
            self.itemsPerRow = 2
        } else {
            self.itemsPerRow = 3
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        self.calculateItemsPerRow(forSize: size)
        flowLayout.invalidateLayout()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTypes.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return DashboardNewsStorage.shared.news.count
        case 1: return DashboardEventStorage.shared.events.count
        default: return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = UICollectionReusableView(frame: CGRect.zero)

        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = SectionTitleCollectionReusableView.dequeue(from: collectionView, ofKind: kind, for: indexPath)
            sectionHeader.setSection(ofType: sectionTypes[indexPath.section])
            sectionHeader.viewController = self
            return sectionHeader
        }

        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: SectionTitleCollectionReusableView.height)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionViewCell = UICollectionViewCell(frame: CGRect.zero)

        switch indexPath.section {
            case 0:
                let newsCell = NewsCollectionViewCell.dequeue(from: collectionView, for: indexPath)
                newsCell.viewController = self
                newsCell.setModel(DashboardNewsStorage.shared.model(for: indexPath))

                collectionViewCell = newsCell
                break
            case 1:
                let eventCell = EventCollectionViewCell.dequeue(from: collectionView, for: indexPath)
                eventCell.viewController = self
                eventCell.setModel(DashboardEventStorage.shared.model(for: indexPath))

                collectionViewCell = eventCell
                break
            default:
                break
        }
        
        collectionViewCell.layoutSubviews()

        return collectionViewCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - view.safeAreaInsets.left - view.safeAreaInsets.right
        let widthPerItem = availableWidth / itemsPerRow

        var size: CGFloat
        switch indexPath.section {
            case 0: size = 300
            case 1: size = 83
            default: size = 0
        }

        return CGSize(width: widthPerItem, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.title = HWStrings.Controllers.Dashboard.sectionEvents
    }
}
