//
//  FontViewCell.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import UIKit

class FontViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var fontLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}

extension FontViewCell: DebugCellInstantiable {
    static func initCell(for tableView: UITableView, with useCase: DebugUseCasable?, on indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath) as! FontViewCell
                
        guard let font = DDStyle.allFonts.first else { return cell }
        cell.nameLabel.text = font.0
        cell.styleLabel.applyStyle(font.1, UIColor.black)
        cell.fontLabel.text = "\(font.1.pointSize)pt"
        
        return cell
    }
}
