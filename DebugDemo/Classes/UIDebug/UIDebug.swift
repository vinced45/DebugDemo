//
//  UIDebug.swift
//  OpenLink
//
//  Created by Vince Davis on 4/1/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import Foundation
import UIKit

struct UIDebug {
    static func instantiateController(named name: String, with useCase: DebugUseCasable? = nil) -> UIViewController? {
        let objectClass = NSClassFromString(name) as? DebugControllerInstantiable.Type
        
        return objectClass?.initController(with: useCase)
    }
    
    static func instantiateCell(named name: String, with tableView: UITableView, on indexPath: IndexPath, using useCase: DebugUseCasable? = nil) -> UITableViewCell? {
        if let objectClass = NSClassFromString(name) as? InitCellable.Type {
            let cell = objectClass.initCell(for: tableView, with: useCase, on: indexPath)
            
            return cell
        }
        
        return nil
    }
    
    static func instantiateButton(named name: String, with useCase: DebugUseCasable? = nil) -> UIButton? {
        let objectClass = NSClassFromString(name) as? DebugButtonInstantiable.Type
        
        return objectClass?.initButton(with: useCase)
    }
    
    static func instantiateView(named name: String, with useCase: DebugUseCasable? = nil) -> UIView? {
        let objectClass = NSClassFromString(name) as? DebugViewInstantiable.Type
        
        return objectClass?.initView(with: useCase)
    }
    
    static func instantiate<T: DebugInstantiable>(type: T.Type, named name: String) -> T? {
        let objectClass = NSClassFromString(name) as? T.Type
        
        return objectClass?.init()
    }
    
    static func getUseCases(for name: String) -> [DebugUseCasable] {
        guard let objectClass = NSClassFromString(name) as? DebugControllerInstantiable.Type else {
            return []
        }
        
        return objectClass.getUseCases()
    }
    
    static func controller(named name: String) -> DebugControllerInstantiable.Type? {
        return NSClassFromString(name) as? DebugControllerInstantiable.Type
    }
}
