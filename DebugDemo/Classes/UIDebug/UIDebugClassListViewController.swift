//
//  UIDebugClassListViewController.swift
//  OpenLink
//
//  Created by Vince Davis on 4/1/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import UIKit

class UIDebugClassListViewController: UIViewController {
    
    var tableView: UITableView!
    
    var tableType: DebugTableType!
    
    var debugItem: UIDebuggable!
    var filteredDebugList = [String]()
    
    var isSectioned: Bool = false
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchFooter = DebugSearchFooterView()
    var searchFooterBottomConstraint: NSLayoutConstraint!
    
    convenience init(for type: DebugTableType, with item: UIDebuggable) {
        self.init()
        
        self.tableType = type
        self.debugItem = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = String(describing: debugItem.classType)
        
        tableView = UITableView(frame: view.bounds, style: tableType.tableStyle)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = self.navigationController?.navigationBar.barTintColor == UIColor.black ? .clear : .gray
        tableView.reloadData()
        
        self.view.addSubview(tableView)
        
        setupSearchController()
        
        tableView.register(UINib(nibName: "ColorViewCell", bundle: nil), forCellReuseIdentifier: "colorCell")
        tableView.register(UINib(nibName: "FontViewCell", bundle: nil), forCellReuseIdentifier: "fontCell")
        
        setup(for: tableType)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = keyboardSize.cgRectValue
        
        if Int(searchFooterBottomConstraint.constant) == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchFooterBottomConstraint.constant -= (keyboardFrame.height - self.view.safeAreaInsets.bottom)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = keyboardSize.cgRectValue
        
        if Int(searchFooterBottomConstraint.constant) != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchFooterBottomConstraint.constant += (keyboardFrame.height - self.view.safeAreaInsets.bottom)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func setup(for tableType: DebugTableType) {
        switch tableType {
        case .classSectionList:
            registerCells()
            isSectioned = true
        default:
            isSectioned = false
        }
        tableView.reloadData()
    }
    
    func registerCells() {
        if debugItem.classType is UITableViewCell.Type {
            for item in debugItem.list {
                if let objectClass = NSClassFromString(item) as? InitCellable.Type {
                    //self.tableView.register(UINib(nibName: item, bundle: nil), forCellReuseIdentifier: "colorCell")
                    print("class name is \(String(describing: objectClass))")
                }
            }
        }
    }
}

// MARK: - TableView DataSource and Delegate
extension UIDebugClassListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSectioned ? debugItem.list.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredDebugList.count, of: debugItem.list.count)
            return isSectioned ? 1 : filteredDebugList.count
        }
        
        searchFooter.setNotFiltering()
        return isSectioned ? 1 : debugItem.list.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !isSectioned {
            return nil
        }
        
        let item: String
        if isFiltering() && section < filteredDebugList.count {
            item = filteredDebugList[section]
        } else {
            item = debugItem.list[section]
        }
        
        let split = item.components(separatedBy: ".")
        return split.count > 1 ? split[1] : split[0]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return isSectioned ? cellForSectioned(with: tableView, on: indexPath) :
                             cellForNonSectioned(with: tableView, on: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !isSectioned {
            let className: String
            if isFiltering() {
                className = filteredDebugList[indexPath.row]
            } else {
                className = debugItem.list[indexPath.row]
            }
            let vc = UIDebugClassDetailViewController(with: className)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITableViewCell Methods
extension UIDebugClassListViewController {
    func cellForNonSectioned(with tableView: UITableView, on indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item: String
        if isFiltering() {
            item = filteredDebugList[indexPath.row]
        } else {
            item = debugItem.list[indexPath.row]
        }
        
        let split = item.components(separatedBy: ".")
        cell.textLabel?.text = split.count > 1 ? split[1] : split[0]
        cell.textLabel?.textColor = self.navigationController?.navigationBar.tintColor
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func cellForSectioned(with tableView: UITableView, on indexPath: IndexPath) -> UITableViewCell {
        let item = debugItem.list[indexPath.section]
        
        if debugItem.classType is UITableViewCell.Type {
            if let cell = UIDebug.instantiateCell(named: item, with: tableView, on: indexPath) {
                cell.textLabel?.text = ""
                cell.selectionStyle = .none
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Not Setup"
        
        return cell
    }
}

// MARK: - SearchController Methods
extension UIDebugClassListViewController {
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
            //searchFooter.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            searchFooterBottomConstraint = searchFooter.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            searchFooterBottomConstraint.isActive = true
        } else {
            //searchFooter.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            searchFooterBottomConstraint = searchFooter.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
            searchFooterBottomConstraint.isActive = true
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredDebugList = debugItem.list.filter({( item: String) -> Bool in
            if searchBarIsEmpty() {
                return true
            } else {
                return item.lowercased().contains(searchText.lowercased())
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

// MARK: - UISearchBarDelegate
extension UIDebugClassListViewController: UISearchBarDelegate {
    internal func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text ?? "")
    }
}

// MARK: - UISearchResultsUpdating
extension UIDebugClassListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}
