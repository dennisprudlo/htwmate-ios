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

    var news: [News] = [
        News(databaseId: 1, title: "News 1", subtitle: "News 1 Description", url: "http://www.google.com", imageUrl: "http://www.google.com", publishDate: "2019-07-07")!,
        News(databaseId: 1, title: "News 1 sadas dasd asd as", subtitle: "News 1 Description", url: "http://www.google.com", imageUrl: "http://www.google.com", publishDate: "2019-07-07")!,
        News(databaseId: 1, title: "Workshops, Gespräche und eine eigene Konferenz ABCDEFGHIJKLMNOPQRSTUVWXYZ", subtitle: "Schulklassen sind am 23. Januar zu Gast, um sich über Studiengänge zu informieren.Schulklassen sind am 23. Januar zu Gast, um sich über Studiengänge zu informieren.", url: "https://www.htw-berlin.de/hochschule/aktuelles/news/news/workshops-gespraeche-und-eine-eigene-konferenz-fuer-schueler-innen/?tx_news_pi1%5Bcontroller%5D=News&tx_news_pi1%5Baction%5D=detail&cHash=af6cb1b0f27e03a03fb2331fb23925c8", imageUrl: "https://www.htw-berlin.de/files/Presse/_tmp_/3/5/csm_DSC05757_b2c7ebe758.jpg", publishDate: "2019-01-19")!,
        News(databaseId: 1, title: "News 1", subtitle: "News 1 Description", url: "http://www.google.com", imageUrl: "http://www.google.com", publishDate: "2019-07-07")!,
        News(databaseId: 1, title: "News 1 sadas dasd asd as", subtitle: "News 1 Description", url: "http://www.google.com", imageUrl: "http://www.google.com", publishDate: "2019-07-07")!,
        News(databaseId: 1, title: "Workshops, Gespräche und eine eigene Konferenz ABCDEFGHIJKLMNOPQRSTUVWXYZ", subtitle: "Schulklassen sind am 23. Januar zu Gast, um sich über Studiengänge zu informieren.Schulklassen sind am 23. Januar zu Gast, um sich über Studiengänge zu informieren.", url: "https://www.htw-berlin.de/hochschule/aktuelles/news/news/workshops-gespraeche-und-eine-eigene-konferenz-fuer-schueler-innen/?tx_news_pi1%5Bcontroller%5D=News&tx_news_pi1%5Baction%5D=detail&cHash=af6cb1b0f27e03a03fb2331fb23925c8", imageUrl: "https://www.htw-berlin.de/files/Presse/_tmp_/3/5/csm_DSC05757_b2c7ebe758.jpg", publishDate: "2019-01-19")!
    ]

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

        newsCell.setTitle(newsItem.title)
        newsCell.setSubtitle(newsItem.subtitle)

        return newsCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace - view.safeAreaInsets.left - view.safeAreaInsets.right
        let widthPerItem = availableWidth / itemsPerRow

       return CGSize(width: widthPerItem, height: 200.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
