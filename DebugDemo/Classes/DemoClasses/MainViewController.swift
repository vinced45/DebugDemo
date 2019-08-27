//
//  MainViewController.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/26/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = .main
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: .debug, style: .done, target: self, action: #selector(showDebug))
        
        let centerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 22))
        centerLabel.text = "MainViewController"
        centerLabel.textAlignment = .center
        centerLabel.center = view.center
        
        view.addSubview(centerLabel)        
    }
}

extension MainViewController {
    @objc func showDebug() {
        let vc = DebugTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: DebugControllerInstantiable {
    static var debugDescription: String {
        return String.mainViewDescription
    }
    
    static func getUseCases() -> [DebugUseCasable] {
        return [DebugDemoUseCase.none, DebugDemoUseCase.redBackground]
    }
    
    static func initController(with useCase: DebugUseCasable?) -> UIViewController {
        let vc = MainViewController()
        
        if let useCase = useCase as? DebugDemoUseCase {
            switch useCase {
            case .redBackground:
                vc.view.backgroundColor = .red
            default: break
            }
        }
        
        return vc
    }
}
