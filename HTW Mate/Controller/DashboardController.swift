//
//  ViewController.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/6/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class DashboardController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets(top: HWInsets.medium, left: HWInsets.medium, bottom: HWInsets.medium, right: HWInsets.medium)

    var news: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        API.shared.newsResource().get { (news, response) in
            self.news = news
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        self.collectionView.backgroundColor = HWColors.contentBackground

        //
        // Set the flow layout to consider the safe area
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInsetReference = .fromSafeArea
        }

        //
        // Calculate the items per row on view load
        self.calculateItemsPerRow(forSize: view.frame.size)
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
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = NewsCollectionViewCell.dequeue(from: collectionView, for: indexPath)
        let newsItem = self.news[indexPath.row]

        newsCell.setModel(newsItem)
        #warning("Snapshot and Contraint error when rotating device")

        return newsCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - view.safeAreaInsets.left - view.safeAreaInsets.right
        let widthPerItem = availableWidth / itemsPerRow

       return CGSize(width: widthPerItem, height: 300.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
