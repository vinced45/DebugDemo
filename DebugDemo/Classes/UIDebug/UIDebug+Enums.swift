//
//  UIDebug+Enums.swift
//  OpenLink
//
//  Created by Vince Davis on 4/4/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import Foundation
import UIKit

enum DetailSection: String, CaseIterable {
    case controller = "Controller"
    case useCase = "Use Case"
    case action = "Action"
}

enum DebugTableType: CaseIterable {
    case bundleList
    case classList
    case classSectionList
    case classDetail
    
    var title: String {
        switch self {
        case .bundleList: return "Bundle Class List"
        case .classList: return "Class List"
        case .classSectionList: return "Class List"
        case .classDetail: return "Class Detail"
        }
    }
    
    var tableStyle: UITableView.Style {
        switch self {
        case .classDetail, .classSectionList: return .grouped
        default: return .plain
        }
    }

}
