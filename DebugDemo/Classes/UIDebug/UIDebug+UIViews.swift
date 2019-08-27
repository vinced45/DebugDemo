//
//  UIDebug+UIViews.swift
//  OpenLink
//
//  Created by Vince Davis on 4/4/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import Foundation
import UIKit

class DebugSearchFooterView: UIView {
    
    let label: UILabel = UILabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        backgroundColor = .gray
        alpha = 0.0
        
        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }
    
    fileprivate func hideFooter() {
        UIView.animate(withDuration: 0.7) { [unowned self] in
            self.alpha = 0.0
        }
    }
    
    fileprivate func showFooter() {
        UIView.animate(withDuration: 0.7) { [unowned self] in
            self.alpha = 1.0
        }
    }
}

extension DebugSearchFooterView {
    public func update(backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        label.textColor = textColor
    }
    
    public func setNotFiltering() {
        label.text = ""
        hideFooter()
    }
    
    public func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        if filteredItemCount == totalItemCount {
            setNotFiltering()
        } else if filteredItemCount == 0 {
            label.text = "No items match your query"
            showFooter()
        } else {
            label.text = "Filtering \(filteredItemCount) of \(totalItemCount)"
            showFooter()
        }
    }
}
