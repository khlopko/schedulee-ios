//
//  AppDelegate.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import CustomUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate let router = Router()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        ErrorNotification.isAutohideEnabled = true
        ErrorNotification.showTimeInterval = 7
        if UserSettings.default.isAnimatedSplash {
            UserSettings.default.isAnimatedSplash = false
        }
        let viewController = UserSettings.default.isAnimatedSplash
            ? SplashViewController()
            : NavigationController(rootViewController: HomeViewController())
        router.createMainWindow(rootViewController: viewController)
        return true
    }
}

extension UIViewController {
    
    var router: Router? {
        return (UIApplication.shared.delegate as? AppDelegate)?.router
    }
}
