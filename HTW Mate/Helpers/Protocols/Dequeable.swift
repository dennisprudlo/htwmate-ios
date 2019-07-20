//
//  DequeuableCollectionViewCell.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 7/7/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

protocol Dequeable {

}

extension Dequeable where Self: UITableViewCell {

    static func dequeue(from tableView: UITableView) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: self.self)) as! Self
    }

}

extension Dequeable where Self: UICollectionViewCell {

    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        collectionView.register(self.self, forCellWithReuseIdentifier: String(describing: self.self))
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self.self), for: indexPath) as! Self
    }

}

extension Dequeable where Self: UICollectionReusableView {

    static func dequeue(from collectionView: UICollectionView, ofKind kind: String, for indexPath: IndexPath) -> Self {
        collectionView.register(self.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: self.self))
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: self.self), for: indexPath) as! Self
    }

}
