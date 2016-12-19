//
//  AppDelegate.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate let router = Router()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        router.createMainWindow(rootViewController: SplashViewController<SplashViewImplementation>())
        return true
    }
}

extension UIViewController {
    
    var router: Router? {
        return (UIApplication.shared.delegate as? AppDelegate)?.router
    }
}
