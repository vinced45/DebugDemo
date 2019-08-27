//
//  UIDebugClassDetailViewController.swift
//  OpenLink
//
//  Created by Vince Davis on 4/1/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import UIKit

public class UIDebugClassDetailViewController: UITableViewController {
    
    public var debugClassName: String!
    var selectedUseCase: DebugUseCasable?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Options"
        
        selectedUseCase = UIDebug.getUseCases(for: debugClassName).first
        
        self.tableView.separatorColor = self.navigationController?.navigationBar.barTintColor == UIColor.black ? .clear : .gray
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    convenience init(with className: String) {
        self.init(style: .grouped)
        
        self.debugClassName = className
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return UIDebug.getUseCases(for: debugClassName).count
        case 2: return 3
        default: return 0
        }
    }
    
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DetailSection.allCases[section].rawValue
    }
    
    override public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        guard let controller = UIDebug.controller(named: debugClassName), section == 0 else {
            return nil
        }
        
        return controller.debugDescription
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            }
            return cell
        }()
        
        cell.textLabel?.textColor = self.navigationController?.navigationBar.tintColor
        
        switch indexPath.section {
        case 0:
            let split = debugClassName.components(separatedBy: ".")
            cell.textLabel?.text = split.count > 1 ? split[1] : split[0]
            cell.textLabel?.textAlignment = .center
        case 1:
            let useCase = UIDebug.getUseCases(for: debugClassName)[indexPath.row]
            cell.textLabel?.text = useCase.name
            cell.detailTextLabel?.text = useCase.useCaseDescription
            cell.accessoryType = selectedUseCase?.name == useCase.name ? .checkmark : .none
            cell.textLabel?.textAlignment = .left
        default:
            switch indexPath.row {
            case 0: cell.textLabel?.text = "Push"
            case 1: cell.textLabel?.text = "Present"
            default: cell.textLabel?.text = "Present with NavigationController"
            }
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            selectedUseCase = UIDebug.getUseCases(for: debugClassName)[indexPath.row]
            for i in 0..<UIDebug.getUseCases(for: debugClassName).count {
                let cell = tableView.cellForRow(at: IndexPath(row: i, section: indexPath.section))
                cell?.accessoryType = (i == indexPath.row) ? .checkmark : .none
            }
        }
        
        if indexPath.section == 2 {
            let controller = UIDebug.instantiateController(named: debugClassName, with: selectedUseCase)
            switch indexPath.row {
            case 0: push(controller: controller)
            case 1: present(controller: controller)
            case 2: presentDismissable(controller: controller)
            default : break
            }
            return
        }
    }
}

// MARK: - Fileprivate Methods
extension UIDebugClassDetailViewController {
    fileprivate func push(controller: UIViewController?) {
        
        guard let controller = controller else {
            return
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    fileprivate func present(controller: UIViewController?) {
        
        guard let controller = controller else {
            return
        }
        present(controller, animated: true, completion: nil)
    }
    
    fileprivate func presentDismissable(controller: UIViewController?) {
        
        guard let controller = controller else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: controller)
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: controller, action: #selector(dismissModalAnimated))
        self.present(navigationController, animated: true, completion: nil)
    }
}
