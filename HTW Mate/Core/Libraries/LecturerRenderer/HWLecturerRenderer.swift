//
//  HWLecturerRenderer.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/16/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import Foundation
import UIKit

class HWLecturerRenderer {

    var data: String
    var components: [HWLecturerRendererComponent] = []

    init () {
        self.data = "[]"
    }

    public func compose() {
        let data = Data(self.data.utf8)
        do {
            if let components = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                self.components = []
                components.forEach { (component) in
                    guard let type = component["type"] as? String else { return }

                    if type == "text" {
                        guard let data = component["data"] as? [String] else { return }
                        guard let href = component["href"] as? [String?] else { return }

                        self.components.append(HWLecturerRendererTextComponent(data: data, href: href))
                    } else if type == "list" {
                        guard let data = component["data"] as? [[String: Any]] else { return }

                        self.components.append(HWLecturerRendererListComponent(data: data))
                    }
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }

    public func hasContent() -> Bool {
        return self.data != "[]"
    }

    public func render(in superView: UIView) {
        superView.subviews.forEach({ $0.removeFromSuperview() })

        var topAnchorHook = superView.topAnchor
        var lastComponentView: UIView?

        self.components.forEach { (component) in
            let componentView = component.render()
            superView.addSubview(componentView)

            componentView.topAnchor.constraint(equalTo: topAnchorHook).isActive = true
            componentView.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
            componentView.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true

            topAnchorHook = componentView.bottomAnchor
            lastComponentView = componentView
        }

        if let last = lastComponentView {
            last.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        }
    }

}
