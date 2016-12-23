//
//  ViewController.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import Tools

class ViewController: UIViewController {
    
    override var navigationController: NavigationController? {
        return super.navigationController as? NavigationController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        router?.currentController = self
    }
}
