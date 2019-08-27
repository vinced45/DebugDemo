//
//  Demo+UIDebug.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import Foundation
import UIKit

enum DemoUIDebug: UIDebuggable, CaseIterable {
    case mainControllers
    case tableCells
    
    var displayName: String {
        switch self {
        case .mainControllers: return .mainAppControllers
        case .tableCells: return .tableViewCells
        }
    }
    
    var bundle: Bundle {
        switch self {
        case .mainControllers: return Bundle.main
        case .tableCells: return Bundle.main
        }
    }
    
    var classType: DebugInstantiable.Type {
        switch self {
        case .mainControllers: return UIViewController.self
        case .tableCells: return UITableViewCell.self
        }
    }
    
    var list: [String] {
        switch self {
        case .mainControllers: return self.bundle.retrieveAll(for: UIViewController.self).sorted(by: { $0 < $1 })
        case .tableCells: return self.bundle.retrieveAll(for: UITableViewCell.self).sorted(by: { $0 < $1 })
        }
    }
}

enum DebugDemoUseCase: DebugUseCasable {
    case none
    case redBackground
    
    var name: String {
        switch self {
        case .none: return .none
        case .redBackground: return .redBackground
        }
    }
    
    var useCaseDescription: String {
        switch self {
        case .none: return .none
        case .redBackground: return .redBackground
        }
    }
}
