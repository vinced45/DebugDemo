//
//  DebugUXStyleTableViewController.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import UIKit

class DebugUXStyleTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = .styleGuide
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70.0
        tableView.estimatedSectionHeaderHeight = 38
        
        tableView.register(UINib(nibName: "ColorViewCell", bundle: nil), forCellReuseIdentifier: "colorCell")
        tableView.register(UINib(nibName: "FontViewCell", bundle: nil), forCellReuseIdentifier: "fontCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? DDColor.allColors.count : DDStyle.allFonts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? .colors : .fonts
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! ColorViewCell
            let color = DDColor.allColors[indexPath.row]
            cell.nameLabel.text = color.0
            cell.hexLabel.text = color.1.hexString()
            cell.colorView.backgroundColor = color.1
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath) as! FontViewCell
        let font = DDStyle.allFonts[indexPath.row]
        cell.nameLabel.text = font.0
        cell.styleLabel.applyStyle(font.1, UIColor.black)
        cell.fontLabel.text = "\(font.1.pointSize)pt"
        
        return cell
    }
}
