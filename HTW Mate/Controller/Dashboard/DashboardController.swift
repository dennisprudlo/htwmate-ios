//
//  ViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    /// The refresh control to easily update the displayed date
    private let refreshControl = UIRefreshControl()

    /// The section reference
    private var dashboardSections: [DashboardSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOnLoad()

        DashboardNewsStorage.shared.delegate = self
        DashboardNewsStorage.shared.reload()

        DashboardEventStorage.shared.delegate = self
        DashboardEventStorage.shared.reload()

        self.configureCollectionView()
        self.configureSections()
    }

    /// Configures the Dashboard controller on view did load
    func configureOnLoad() {
        self.setStatusBarOverlay()

        //
        // Add the refresh control to the collection view. In case of a iOS 9 system or even older system
        // add the refresh control as a subview. UIKit will automatically know what to do with it
        if #available(iOS 10.0, *) {
            self.collectionView.refreshControl = refreshControl
        } else {
            self.collectionView.addSubview(refreshControl)
        }

        self.refreshControl.addTarget(self, action: #selector(didRefreshCollectionView), for: .valueChanged)
    }

    /// Configures the collection view and registers necessary cells
    func configureCollectionView() {
        //
        // Register cells
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: NewsCollectionViewCell.self))
        collectionView.register(SectionTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SectionTitleCollectionReusableView.self))
        collectionView.register(SectionSettingsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: SectionSettingsCollectionReusableView.self))

        //
        // Adjust safe area insets for header and footer views
        collectionView.contentInsetAdjustmentBehavior = .always

        collectionView.backgroundColor = HWColors.contentBackground

        //
        // Set the flow layout to consider the safe area
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInsetReference = .fromSafeArea
        }
    }

    /// Build the section array for dynamic display of the collection view
    func configureSections() {
        dashboardSections.append(DashboardSettingsSection())
        dashboardSections.append(DashboardNewsSection())
        dashboardSections.append(DashboardEventSection())
    }

    /// Checks whether the collection view shoud reload its data and reload if necessary
    public func checkCollectionViewReload() {
        if DashboardNewsStorage.shared.loaded && DashboardEventStorage.shared.loaded {
            refreshControl.endRefreshing()
            collectionView.reloadData()
        }
    }

    /// Triggered when the user refreshes the collection view using the refresh control
    /// Reloads the data storage
    @objc private func didRefreshCollectionView() {
        DashboardNewsStorage.shared.reload()
        DashboardEventStorage.shared.reload()
    }

    /// invalidate the collection views flow layout and recalculate the items per row
    ///
    /// - Parameters:
    ///   - size: The new size the screen has transitioned to
    ///   - coordinator: The transition coordinator
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        flowLayout.invalidateLayout()
    }

    /// Returns the number of section the collection view should display
    ///
    /// - Parameter collectionView: The collection view which will display the sections
    /// - Returns: The number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dashboardSections.count
    }

    /// Returns the number of items in a section the collection view should display
    ///
    /// - Parameters:
    ///   - collectionView: The collection view which will display the items
    ///   - section: The section of which the item count is needed
    /// - Returns: The number of items of the given section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardSections[section].numberOfItems()
    }


    /// Returns the supplementary element view for a given index path
    ///
    /// - Parameters:
    ///   - collectionView: The collectionView as a reference
    ///   - kind: The kind of the supplementary view
    ///   - indexPath: The indexPath
    /// - Returns: A collection reusable view
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return dashboardSections[indexPath.section].supplementaryHeader(at: indexPath, in: collectionView, presentingController: self)
    }


    /// Calculates the size of the supplementary header in a given section
    ///
    /// - Parameters:
    ///   - collectionView: The collectionView as a reference
    ///   - collectionViewLayout: The collectionViewLayout as a reference
    ///   - section: The section where to retrieve the header size from
    /// - Returns: The CGSize instance with a width and height information
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: dashboardSections[section].supplementaryHeaderHeight())
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var collectionViewCell = UICollectionViewCell(frame: CGRect.zero)
        switch indexPath.section {
            case 0:
                break;
            case 1:
                let newsCell = NewsCollectionViewCell.dequeue(from: collectionView, for: indexPath)
                newsCell.viewController = self
                newsCell.setModel(DashboardNewsStorage.shared.model(for: indexPath))

                collectionViewCell = newsCell
                break
            case 2:
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

    /// Returns the size for a specific item at the given index path
    ///
    /// - Parameters:
    ///   - collectionView: The collectionView as a reference
    ///   - collectionViewLayout: The collectionViewLayout as a reference
    ///   - indexPath: The items index path
    /// - Returns: The items size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = dashboardSections[indexPath.section].itemsPerRow(forSize: self.view.frame.size)

        let paddingSpace = HWInsets.standard * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - view.safeAreaInsets.left - view.safeAreaInsets.right
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)

        return CGSize(width: widthPerItem, height: dashboardSections[indexPath.section].itemHeight(at: indexPath))
    }

    /// The inseet on each edge for the given section
    ///
    /// - Parameters:
    ///   - collectionView: The collectionView as a reference
    ///   - collectionViewLayout: The collectionViewLayout as a reference
    ///   - section: The section of which the insets are retrieved
    /// - Returns: The UIEdgeInsets instance with the inset information
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return dashboardSections[section].sectionInsets()
    }


    /// The minimum space between items in the given section
    ///
    /// For vertical scrolling sections (up-down) its the space between the rows in a section
    ///
    /// - Parameters:
    ///   - collectionView: The collectionView as a reference
    ///   - collectionViewLayout: The collectionViewLayout as a reference
    ///   - section: The section we want to handle
    /// - Returns: The minimum space between items in the given section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return HWInsets.standard
    }
}
