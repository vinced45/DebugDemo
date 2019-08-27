//
//  DDStyle.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import Foundation
import UIKit

struct DDStyle {
    static let allFonts = [
        ("Title 1 (heavy)", DDStyle.title1Font),
        ("Title 2", DDStyle.title2Font),
        ("Title 3", DDStyle.title3Font),
        ("Headline (heavy)", DDStyle.headlineFont),
        ("Button (bold)", DDStyle.buttonFont),
        ("Body", DDStyle.bodyFont),
        ("Body (bold)", DDStyle.boldBodyFont),
        ("Body (italic)", DDStyle.italicBodyFont),
        ("Link (bold)", DDStyle.linkFont),
        ("Callout", DDStyle.calloutFont),
        ("Subhead", DDStyle.subheadFont),
        ("Footnote", DDStyle.footnoteFont),
        ("Footnote Action", DDStyle.footnoteActionFont),
        ("Tile Title", DDStyle.tileTitleFont),
        ("Caption", DDStyle.captionFont),
        ("Caption (bold)", DDStyle.boldCaptionFont),
    ]
    
    static let title1Font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)
    static let title2Font = UIFont.systemFont(ofSize: 22)
    static let title3Font = UIFont.systemFont(ofSize: 20)
    static let headlineFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.heavy)
    static let buttonFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    static let bodyFont = UIFont.systemFont(ofSize: 17)
    static let boldBodyFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
    static let italicBodyFont = UIFont.systemFont(ofSize: 17).italic()
    static let linkFont = UIFont.boldSystemFont(ofSize: 17)
    static let calloutFont = UIFont.systemFont(ofSize: 16)
    static let subheadFont = UIFont.systemFont(ofSize: 15)
    static let footnoteFont = UIFont.systemFont(ofSize: 13)
    static let footnoteActionFont = UIFont.systemFont(ofSize: 12)
    static let tileTitleFont = UIFont.systemFont(ofSize: 12)
    static let captionFont = UIFont.systemFont(ofSize: 13)
    static let boldCaptionFont = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
}

extension UIFont {
    
    func with(traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        if let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        return self
    }
    
    func boldItalic() -> UIFont {
        return with(traits: .traitBold, .traitItalic)
    }
    
    func italic() -> UIFont {
        return with(traits: .traitItalic)
    }
}
extension UINavigationBar {
    
    func applyGrayStyle() {
        UIApplication.shared.statusBarStyle = .default
        isTranslucent = false
        barTintColor = DDColor.grayLightest
        tintColor = DDColor.action
        backgroundColor = nil
        
        let navBarTitleTextAttributes = [NSAttributedString.Key.foregroundColor: DDColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)]
        titleTextAttributes = navBarTitleTextAttributes
    }
}

extension UIButton {
    
    func applyPrimaryActionButtonStyle() {
        layer.cornerRadius = 8
        backgroundColor = DDColor.action
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = DDStyle.headlineFont
        clipsToBounds = true
    }
    
    func applyHollowPrimaryActionButtonStyle() {
        layer.cornerRadius = 8
        backgroundColor = UIColor.clear
        layer.borderColor = DDColor.action.cgColor
        layer.borderWidth = 1.5
        setTitleColor(DDColor.action, for: .normal)
        titleLabel?.font = DDStyle.headlineFont
        clipsToBounds = true
    }
    
    func applySecondaryActionButtonStyle() {
        setTitleColor(DDColor.action, for: .normal)
        titleLabel?.font = DDStyle.bodyFont
    }
    
    func applyFootnoteActionButtonStyle() {
        setTitleColor(DDColor.action, for: .normal)
        titleLabel?.font = DDStyle.footnoteActionFont
    }
    
    func applyDestructiveButtonStyle() {
        setTitleColor(DDColor.actionDestructive, for: .normal)
        titleLabel?.font = DDStyle.bodyFont
    }
    
}

extension UITextView {
    
    func applyStyle(_ font: UIFont, _ color: UIColor) {
        self.font = font
        textColor = color
    }
}

extension UILabel {
    
    func applyStyle(_ font: UIFont, _ color: UIColor) {
        self.font = font
        textColor = color
    }
    
    func applyHeaderStyle() {
        font = DDStyle.subheadFont
        textColor = DDColor.grayDark
    }
    
    func applyFootnoteStyle() {
        font = DDStyle.footnoteFont
        textColor = DDColor.gray
    }
    
    func applyRoundUnSelectedStyle() {
        textColor = UIColor.black
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = DDColor.action.cgColor
    }
    
    func applyRoundSelectedStyle() {
        textColor = UIColor.white
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 1.0
        layer.masksToBounds = true
        layer.backgroundColor = DDColor.action.cgColor
        layer.borderColor = UIColor.black.cgColor
    }
}

