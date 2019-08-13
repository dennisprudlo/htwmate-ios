//
//  ViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private var itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: HWInsets.medium, left: HWInsets.medium, bottom: HWInsets.medium, right: HWInsets.medium)

    let sectionTitles = [
        HWStrings.Controllers.Dashboard.sectionNews,
        HWStrings.Controllers.Dashboard.sectionEvents
    ]

    var news: [News] = []
    var events: [Event] = []

    var newsDataLoaded = false
    var eventsDataLoaded = false

    /// The refresh control to easily update the displayed date
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.title = HWStrings.Controllers.Dashboard.title

        //
        // Add the refresh control to the collection view. In case of a iOS 9 system or even older system
        // add the refresh control as a subview. UIKit will automatically know what to do with it
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }

        refreshControl.addTarget(self, action: #selector(didRefreshCollectionView(_:)), for: .valueChanged)
        
        loadNewsArticles()
        loadEvents()

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

    private func loadNewsArticles() -> Void {
        API.shared.newsResource().get(limit: 6) { (news, response) in
            self.news = news
            DispatchQueue.main.async {
                LogManager.shared.put("Dashboard news articles loaded")
                self.newsDataLoaded = true
                self.checkCollectionViewReload()
            }
        }
    }

    private func loadEvents() -> Void {
        API.shared.eventsResource().get(limit: 6) { (events, response) in
            self.events = events
            DispatchQueue.main.async {
                LogManager.shared.put("Dashboard events loaded")
                self.eventsDataLoaded = true
                self.checkCollectionViewReload()
            }
        }
    }

    private func checkCollectionViewReload() -> Void {
        if newsDataLoaded && eventsDataLoaded {
            refreshControl.endRefreshing()
            collectionView.reloadData()
        }
    }

    @objc private func didRefreshCollectionView(_ sender: Any) {
        newsDataLoaded = false
        eventsDataLoaded = false
        loadNewsArticles()
        loadEvents()
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
        return sectionTitles.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return self.news.count
        case 1: return self.events.count
        default: return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = UICollectionReusableView(frame: CGRect.zero)

        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = SectionTitleCollectionReusableView.dequeue(from: collectionView, ofKind: kind, for: indexPath)
            sectionHeader.setTitle(sectionTitles[indexPath.section])
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

                newsCell.setViewController(self)
                newsCell.setModel(self.news[indexPath.row])

                collectionViewCell = newsCell
                break
            case 1:
                let eventCell = EventCollectionViewCell.dequeue(from: collectionView, for: indexPath)

                eventCell.setViewController(self)
                eventCell.setModel(self.events[indexPath.row])

                collectionViewCell = eventCell
                break
            default:
                break
        }
        #warning("Snapshot and Contraint error when rotating device")

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
}
