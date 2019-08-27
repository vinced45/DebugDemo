//
//  UIDebug+Protocols.swift
//  OpenLink
//
//  Created by Vince Davis on 4/1/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import Foundation
import UIKit

public protocol UIDebuggable {
    var displayName: String { get }
    var bundle: Bundle { get }
    var classType: DebugInstantiable.Type { get }
    var list: [String] { get }
}

public protocol DebugUseCasable {
    var name: String { get }
    var useCaseDescription: String { get }
}

public protocol DebugInstantiable: class {
    init()
}

public protocol DebugControllerInstantiable {
    static var debugDescription: String { get }
    static func getUseCases() -> [DebugUseCasable]
    static func initController(with useCase: DebugUseCasable?) -> UIViewController
}

public protocol DebugCellInstantiable {
    static func initCell(for tableView: UITableView, with useCase: DebugUseCasable?, on indexPath: IndexPath) -> UITableViewCell
}

public protocol DebugViewInstantiable {
    static func initView(with useCase: DebugUseCasable?) -> UIView
}

public protocol DebugButtonInstantiable {
    static func initButton(with useCase: DebugUseCasable?) -> UIButton
}

extension UIViewController: DebugInstantiable {}
extension UIView: DebugInstantiable {}

typealias InitCellable = DebugInstantiable & DebugCellInstantiable
typealias InitViewable = DebugInstantiable & DebugViewInstantiable
