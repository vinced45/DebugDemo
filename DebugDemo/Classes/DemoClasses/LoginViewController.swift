//
//  LoginViewController.swift
//  DebugDemo
//
//  Created by Vince Davis on 8/27/19.
//  Copyright © 2019 Vince Davis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = .login
    }
}

extension LoginViewController: DebugControllerInstantiable {
    static var debugDescription: String {
        return String.loginViewDescription
    }
    
    static func getUseCases() -> [DebugUseCasable] {
        return [DebugDemoUseCase.none]
    }
    
    static func initController(with useCase: DebugUseCasable?) -> UIViewController {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        
        return vc
    }
}
