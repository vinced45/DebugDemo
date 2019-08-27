//
//  UIDebugBundleListViewController.swift
//  OpenLink
//
//  Created by Vince Davis on 4/4/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

public class UIDebugBundleListViewController: UIViewController {

    var tableView: UITableView!
    
    var debugList: [UIDebuggable]!
    var filteredDebugList = [UIDebuggable]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchFooter = DebugSearchFooterView()
    
    public convenience init(with list: [UIDebuggable]) {
        self.init()
        
        self.debugList = list
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Bundle List"
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorColor = self.navigationController?.navigationBar.barTintColor == UIColor.black ? .clear : .gray
        tableView.reloadData()
        
        self.view.addSubview(tableView)
        setupSearchController()
    }
}

extension UIDebugBundleListViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredDebugList.count, of: debugList.count)
            return filteredDebugList.count
        }
        
        searchFooter.setNotFiltering()
        return debugList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let item: UIDebuggable
        if isFiltering() {
            item = filteredDebugList[indexPath.row]
        } else {
            item = debugList[indexPath.row]
        }
        
        cell.textLabel?.text = "\(item.displayName) (\(item.list.count))"
        cell.textLabel?.textColor = self.navigationController?.navigationBar.tintColor
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let debugItem = debugList[indexPath.row]
        
        if debugItem.classType is UIViewController.Type {
            let vc = UIDebugClassListViewController(for: .classList, with: debugItem)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if debugItem.classType is UITableViewCell.Type {
            let vc = UIDebugClassListViewController(for: .classSectionList, with: debugItem)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        if debugItem.classType is UIView.Type {
            let vc = UIDebugClassCollectionViewController(with: debugItem)
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
}

extension UIDebugBundleListViewController {
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Objects"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        
        self.view.addSubview(searchFooter)
        if let backgroundColor = self.navigationController?.navigationBar.barTintColor,
            let textColor = self.navigationController?.navigationBar.tintColor {
            searchFooter.update(backgroundColor: backgroundColor, textColor: textColor)
        }
                
        searchFooter.translatesAutoresizingMaskIntoConstraints = false
        searchFooter.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchFooter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        searchFooter.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        if #available(iOS 11, *) {
            searchFooter.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            searchFooter.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredDebugList = debugList.filter({( item: UIDebuggable) -> Bool in
            if searchBarIsEmpty() {
                return true
            } else {
                return item.displayName.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension UIDebugBundleListViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text ?? "")
    }
}

extension UIDebugBundleListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}
