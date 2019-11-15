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
