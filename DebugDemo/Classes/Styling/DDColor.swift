//
//  DDColor.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import Foundation
import UIKit

struct DDColor {
    static let allColors = [("Brand Red", DDColor.brandRed),
                            ("Brand Red Gradient", DDColor.brandRedGradient),
                            ("Info Error", DDColor.infoError),
                            ("Info Error Bkg", DDColor.infoErrorBackground),
                            ("Info Warning", DDColor.infoWarning),
                            ("Info Warning Bkg", DDColor.infoWarningBackground),
                            ("Info Success", DDColor.infoSuccess),
                            ("Info Success Bkg", DDColor.infoSuccessBackground),
                            ("Info Info", DDColor.infoInformation),
                            ("Info Info Bkg", DDColor.infoInformationBackground),
                            ("Action", DDColor.action),
                            ("Action Destructive", DDColor.actionDestructive),
                            ("Selected Row", DDColor.selectedRow),
                            ("Black", DDColor.black),
                            ("Gray Lightest", DDColor.grayLightest),
                            ("Gray Light", DDColor.grayLight),
                            ("Standard Gray", DDColor.standardGray),
                            ("Gray", DDColor.gray),
                            ("Gray Dark", DDColor.grayDark),
                            ("Placeholder", DDColor.placeholder)
    ]
    
    static let brandRed = UIColor(rgb: 0xdb011c)
    static let brandRedGradient = UIColor(rgb: 0xb70118)
    
    static let infoError = UIColor(rgb: 0xec130e)                    //Style Guide: Error Saturated
    static let infoErrorBackground = UIColor(rgb: 0xf64e58)          //Style Guide: Error
    
    static let infoWarning = UIColor(rgb: 0xc85208)                  //Style Guide: Warning Saturated
    static let infoWarningBackground = UIColor(rgb: 0xf89845)        //Style Guide: Warning
    
    static let infoSuccess = UIColor(rgb: 0x3c7c00)                  //Style Guide: Success Saturated
    static let infoSuccessBackground = UIColor(rgb: 0x8bd445)        //Style Guide: Success
    
    static let infoInformation = UIColor(rgb: 0x3d7ab7)              //Style Guide: Info Saturated
    static let infoInformationBackground = UIColor(rgb: 0x71b9ed)    //Style Guide: Info
    
    static let action = UIColor(rgb: 0x076ae6)
    static let selectedRow = UIColor(rgb: 0xD8E3F0)
    static let actionDestructive = DDColor.infoError
    static let black = UIColor(rgb: 0x090a0f)  // web black
    static let greenCheck = UIColor(rgb: 0x4f842a)
    
    static let grayLightest = UIColor(rgb: 0xf0f0f0)
    static let grayLight = UIColor(rgb: 0xbfbfbf)
    static let standardGray = UIColor(rgb: 0x8D8D8D)
    static let gray = UIColor(rgb: 0x515355)
    static let grayDark = UIColor(rgb: 0x343434)
    
    static let placeholder = UIColor(rgb: 0x8D8D8D)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func hexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        
        return String(format: "#%06x", rgb)
    }
}
