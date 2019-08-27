//
//  UIDebug+Extensions.swift
//  OpenLink
//
//  Created by Vince Davis on 4/1/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func dismissModalAnimated() {
        self.dismiss(animated: true, completion: nil)
    }
}

public extension Bundle {
    func retrieveAll<T: DebugInstantiable>(for classType: T.Type) -> [String] {
        guard let bundlePath = self.executablePath else {
            return []
        }
        
        var anyClasses: [String] = []
        var size: UInt32 = 0
        
        let classes = objc_copyClassNamesForImage(bundlePath, &size)
        
        for index in 0..<size {
            if let className = classes?[Int(index)],
                let name = NSString(utf8String: className) as String? {
                if NSClassFromString(name) is T.Type {
                    anyClasses.append(name)
                }
            }
        }
        
        return anyClasses
    }
}
