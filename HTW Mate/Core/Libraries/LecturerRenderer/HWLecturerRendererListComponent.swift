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

            let listItemView = UIView()
            listItemView.translatesAutoresizingMaskIntoConstraints = false

            var listItemTopAnchorHook = listItemView.topAnchor
            var lastListItemComponentView: UIView?

			let bulletPoint = UILabel()
            bulletPoint.translatesAutoresizingMaskIntoConstraints = false
            bulletPoint.text = "\u{2022}"
			bulletPoint.textColor = HWColors.primaryText
			bulletPoint.font = Font.shared.scaled(textStyle: .body, weight: .regular)
            listItemView.addSubview(bulletPoint)
            
            data.forEach({ (textComponent) in
                guard let textComponentData = textComponent["data"] as? [String] else { return }
                guard let textComponentHref = textComponent["href"] as? [String?] else { return }

                let textComponentView = HWLecturerRendererTextComponent(data: textComponentData, href: textComponentHref).render()
                listItemView.addSubview(textComponentView)
				textComponentView.topAnchor.constraint(equalTo: listItemTopAnchorHook, constant: HWInsets.extraSmall).isActive = true
				textComponentView.leadingAnchor.constraint(equalTo: listItemView.leadingAnchor, constant: bulletPoint.font.pointSize).isActive = true
                textComponentView.trailingAnchor.constraint(equalTo: listItemView.trailingAnchor).isActive = true

                listItemTopAnchorHook = textComponentView.bottomAnchor
                lastListItemComponentView = textComponentView
            })

			bulletPoint.topAnchor.constraint(equalTo: listItemView.topAnchor, constant: HWInsets.extraSmall).isActive = true
            bulletPoint.leadingAnchor.constraint(equalTo: listItemView.leadingAnchor).isActive = true

            if let last = lastListItemComponentView {
                last.bottomAnchor.constraint(equalTo: listItemView.bottomAnchor).isActive = true
            }

            listView.addSubview(listItemView)
            listItemView.topAnchor.constraint(equalTo: topAnchorHook).isActive = true
            listItemView.leadingAnchor.constraint(equalTo: listView.leadingAnchor).isActive = true
            listItemView.trailingAnchor.constraint(equalTo: listView.trailingAnchor).isActive = true

            topAnchorHook = listItemView.bottomAnchor
            lastComponentView = listItemView
        }

        if let last = lastComponentView {
            last.bottomAnchor.constraint(equalTo: listView.bottomAnchor).isActive = true
        }

        return listView
    }
}
