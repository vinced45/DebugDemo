//
//  UIDebugClassCollectionViewController.swift
//  OpenLink
//
//  Created by Vince Davis on 4/5/19.
//  Copyright © 2019 Milwaukee Tool. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class UIDebugClassCollectionViewController: UIViewController {

    var debugItem: UIDebuggable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        
        self.title = String(describing: debugItem.classType)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: self.view.frame.size.width - 30, height: 400)
        
        let collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .lightGray
        self.view.addSubview(collectionView)
    }
    
    convenience init(with item: UIDebuggable) {
        self.init()
        
        self.debugItem = item
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension UIDebugClassCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return debugItem.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = .white
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let item = debugItem.list[indexPath.row]
        let split = item.components(separatedBy: ".")
        let className = split.count > 1 ? split[1] : split[0]
        
        let classLabel = UILabel()
        classLabel.font = .boldSystemFont(ofSize: 18)
        
        let stackView = UIStackView()
        cell.contentView.addSubview(stackView)
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 5).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -5).isActive = true
        stackView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -5).isActive = true
        stackView.addArrangedSubview(classLabel)
        
        classLabel.text = className
        classLabel.textColor = self.navigationController?.navigationBar.tintColor
        
        if let view = UIDebug.instantiateView(named: item) {
            view.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
            view.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
            stackView.addArrangedSubview(view)
            
            return cell
        }
        
        if let button = UIDebug.instantiateButton(named: item) {
            button.heightAnchor.constraint(equalToConstant: button.frame.size.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: button.frame.size.width).isActive = true
            stackView.addArrangedSubview(button)
            
            return cell
        }
        
        let notSetupLabel = UILabel()
        notSetupLabel.text = "Not Setup"
        notSetupLabel.textColor = self.navigationController?.navigationBar.tintColor
        notSetupLabel.font = .boldSystemFont(ofSize: 14)
        stackView.addArrangedSubview(notSetupLabel)
        
        return cell
    }
}

extension UIDebugClassCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let className = debugItem.list[indexPath.row]
        if let view = UIDebug.instantiateView(named: className) {
            let size = CGSize(width: self.view.frame.size.width - 30, height: view.frame.size.height + 30)
            return size
        }
        
        if let button = UIDebug.instantiateButton(named: className) {
            let size = CGSize(width: self.view.frame.size.width - 30, height: button.frame.size.height + 30)
            return size
        }
        
        let size = CGSize(width: self.view.frame.size.width - 30, height: 60)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
