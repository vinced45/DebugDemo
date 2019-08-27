//
//  StringTableViewController.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import UIKit

class StringTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = .strings
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.register(UINib(nibName: "StringsViewCell", bundle: nil), forCellReuseIdentifier: "stringsCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DDString.allFonts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stringsCell", for: indexPath) as! StringsViewCell
        
        let string = DDString.allFonts[indexPath.row]
        
        cell.keyLabel.text = string.0
        cell.stringLabel.text = string.1

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
