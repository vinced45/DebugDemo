//
//  ColorViewCell.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import UIKit

class ColorViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension ColorViewCell: DebugCellInstantiable {
    static func initCell(for tableView: UITableView, with useCase: DebugUseCasable?, on indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! ColorViewCell
        
        guard let color = DDColor.allColors.first else {
            return cell
        }
        
        cell.nameLabel.text = color.0
        cell.hexLabel.text = color.1.hexString()
        cell.colorView.backgroundColor = color.1
        
        return cell
    }
}
