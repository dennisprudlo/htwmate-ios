//
//  HWLecturerRendererTextComponent.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 8/16/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class HWLecturerRendererTextComponent: HWLecturerRendererComponent {

    var data: [String]
    var href: [String?]

    init(data: [String], href: [String?]) {
        self.data = data
        self.href = href
    }

    override func render() -> UIView {
        let attributed = NSAttributedString(string: data.joined())
        let mutable = NSMutableAttributedString(attributedString: attributed)

        var index = 0
        var characterIndex = 0
        self.href.forEach { (href) in
            let characterCount = self.data[index].count

            if let stringUrl = href, let url = URL(string: stringUrl) {
                let range = NSRange(location: characterIndex, length: characterCount)
                mutable.addAttribute(.link, value: url, range: range)
            }

            index += 1
            characterIndex += characterCount
        }

        let textComponent = UITextView()
        textComponent.translatesAutoresizingMaskIntoConstraints = false
        textComponent.attributedText = mutable
        textComponent.sizeToFit()
        textComponent.isScrollEnabled = false
        textComponent.isEditable = false
        textComponent.isSelectable = true
        textComponent.textContainerInset = UIEdgeInsets.zero
        textComponent.textContainer.lineFragmentPadding = 0
        textComponent.font = UIFont.systemFont(ofSize: HWFontSize.strongText)
		textComponent.textColor = HWColors.primaryText
        textComponent.linkTextAttributes = [NSAttributedString.Key.foregroundColor: HWColors.StyleGuide.primaryGreen]
        return textComponent
    }
}
