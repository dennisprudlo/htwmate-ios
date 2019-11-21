//
//  Font.swift
//  HTW Mate
//
//  Created by Dennis Prudlo on 11/12/19.
//  Copyright © 2019 Dennis Prudlo. All rights reserved.
//

import UIKit

class Font {

	static let shared: Font = Font(face: .lato)
	
	enum Face: String {
		case lato = "Lato"
	}
	
	enum Weight {
		case thin
		case thinItalic
		case light
		case lightItalic
		case regular
		case italic
		case bold
		case boldItalic
		case black
		case blackItalic
	}
	
	enum Size: CGFloat {
		case sectionTitle	= 28;
		case title			= 27;
		case regular		= 17;
		case strong			= 15;
		case text			= 13;
		case small			= 12;
		case extraSmall		= 10;
	}
	
	private let face: Font.Face
	
	init(face: Font.Face) {
		self.face = face
	}
	
	func font(pointSize: CGFloat, weight: Font.Weight = .regular) -> UIFont {
		let fontNames: [Font.Weight: [Font.Face: String]] = [
			.thin:			[.lato: "Late-Hairline"],
			.thinItalic:	[.lato: "Lato-HairlineItalic"],
			.light:			[.lato: "Lato-Light"],
			.lightItalic:	[.lato: "Lato-LightItalic"],
			.regular:		[.lato: "Lato-Regular"],
			.italic:		[.lato: "Lato-Italic"],
			.bold:			[.lato: "Lato-Bold"],
			.boldItalic:	[.lato: "Lato-BoldItalic"],
			.black:			[.lato: "Lato-Black"],
			.blackItalic:	[.lato: "Lato-BlackItalic"]
		]

		guard let fontName = fontNames[weight]?[self.face] else {
			fatalError("Failed to retrieve font name for \(self.face) in \(weight) style.")
		}
		
		guard let font = UIFont(name: fontName, size: pointSize) else {
            fatalError("Failed to load the font \(fontName). Make sure the font file is included in the project and the font name is spelled correctly.")
        }
		
		return font
	}
	
	func get(fontSize: Font.Size = .text, weight: Font.Weight = .regular) -> UIFont {
		return self.font(pointSize: fontSize.rawValue, weight: weight)
	}
	
	func scaled(textStyle: UIFont.TextStyle, weight: Font.Weight = .regular) -> UIFont {
		let pointSize	= UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        let font		= self.font(pointSize: pointSize, weight: weight)
		
        return UIFontMetrics.default.scaledFont(for: font)
	}
}
