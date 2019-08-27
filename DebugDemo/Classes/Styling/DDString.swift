//
//  String+Extension.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import Foundation
import UIKit

struct DDString {
    static let allFonts = [
        ("Main", String.main),
        ("Debug", String.debug),
        ("Main View Description", String.mainViewDescription),
        ("Main App Controllers", String.mainAppControllers),
        ("Table View Cells", String.tableViewCells),
        ("None", String.none),
        ("Red Background", String.redBackground),
        ("Style Guide", String.styleGuide),
        ("Colors", String.colors),
        ("Fonts", String.fonts),
        ("Hidden Debug", String.hiddenDebug),
        ("Strings", String.strings),
        ("Debug Views", String.debugViews),
        ("Views", String.views),
        ]
}

extension String {
    var localized: String {
        return localized(comment: "")
    }
    
    func localized(comment: String = "") -> String {
        let translatedString = NSLocalizedString(self, comment: comment)
        return translatedString
    }
}

// MARK: - Static Text Strings
extension String {
    static let main = "Main".localized
    static let debug = "Debug".localized
    static let mainViewDescription = "This Controller is the main controller of the app".localized
    static let loginViewDescription = "This Controller is the login controller of the app".localized
    static let mainAppControllers = "Main App Controllers".localized
    static let tableViewCells = "Table View Cells".localized
    static let none = "None".localized
    static let redBackground = "Red Background".localized
    static let styleGuide = "Style Guide".localized
    static let colors = "Colors".localized
    static let fonts = "Fonts".localized
    static let hiddenDebug = "Hidden Debug".localized
    static let strings = "Strings".localized
    static let debugViews = "Debug Views".localized
    static let views = "Views".localized
    static let login = "Login".localized
    static let hidePassword = "Hide Password Field".localized
}
