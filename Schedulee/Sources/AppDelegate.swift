//
//  AppDelegate.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import Tools

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate let router = Router()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        router.createMainWindow(rootViewController: SplashViewController())
        return true
    }
}

extension UIViewController {
    
    var router: Router? {
        return (UIApplication.shared.delegate as? AppDelegate)?.router
    }
}

