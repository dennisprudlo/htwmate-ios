//
//  HWLecturerRendererListComponent.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/17/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWLecturerRendererListComponent: HWLecturerRendererComponent {

    var data: [[String: Any]]

    init(data: [[String: Any]]) {
        self.data = data
    }

    override func render() -> UIView {
        let listView = UIView()
        listView.translatesAutoresizingMaskIntoConstraints = false

        var topAnchorHook = listView.topAnchor
        var lastComponentView: UIView?

        self.data.forEach { (listItem) in
            guard let type = listItem["type"] as? String, type == "listitem" else { return }
            guard let data = listItem["data"] as? [[String: Any]] else { return }

            data.forEach({ (textComponent) in
                guard let textComponentData = textComponent["data"] as? [String] else { return }
                guard let textComponentHref = textComponent["href"] as? [String?] else { return }

                let textComponentView = HWLecturerRendererTextComponent(data: textComponentData, href: textComponentHref).render()
                listView.addSubview(textComponentView)
                textComponentView.topAnchor.constraint(equalTo: topAnchorHook).isActive = true
                textComponentView.leadingAnchor.constraint(equalTo: listView.leadingAnchor).isActive = true
                textComponentView.trailingAnchor.constraint(equalTo: listView.trailingAnchor).isActive = true

                topAnchorHook = textComponentView.bottomAnchor
                lastComponentView = textComponentView
            })
        }

        if let last = lastComponentView {
            last.bottomAnchor.constraint(equalTo: listView.bottomAnchor).isActive = true
        }

        return listView
    }
}
