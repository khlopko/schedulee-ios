//
//  Router.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import Models

final class Router {
    
    let mainWindow = UIWindow(frame: UIScreen.main.bounds)
    
    weak var currentNavigation: UINavigationController?
    weak var currentController: UIViewController?
    
    private var lastRouteType: RouteType?

    // MARK: - Main window
    
    func createMainWindow(rootViewController: UIViewController? = nil) {
        mainWindow.backgroundColor = .white
        mainWindow.rootViewController = rootViewController
        mainWindow.makeKeyAndVisible()
    }
    
    func changeRootViewController(to viewController: UIViewController, animated: Bool) {
        let duration: TimeInterval = animated ? 1 : 0
        let navigation = NavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        navigation.pushViewController(viewController, animated: false)
        navigation.setNavigationBarHidden(true, animated: false)
        UIView.transition(
            with: mainWindow,
            duration: duration,
            options: [.transitionCrossDissolve],
            animations: {
                self.mainWindow.rootViewController = navigation
        },
            completion: nil)
    }
    
    func push(route: Route) {
        let viewController = route.viewController
        currentNavigation?.pushViewController(viewController, animated: true)
        lastRouteType = .push
    }
    
    func present(route: Route) {
        let viewController = route.viewController
        currentController?.present(viewController, animated: true, completion: nil)
        lastRouteType = .present
    }
    
    func back() {
        guard let lastRouteType = lastRouteType else {
            return
        }
        switch lastRouteType {
        case .push:
            _ = currentNavigation?.popViewController(animated: true)
        case .present:
            currentController?.dismiss(animated: true, completion: nil)
        }
        self.lastRouteType = nil
    }
}

// MARK: - Route

extension Router {
    
    enum Route {
        
        case lessons(current: Lesson?)
        case lectors
        case timetable
        case settings
        
        var viewController: UIViewController {
            switch self {
            case .lessons(let current):
                return LessonsViewController(currentLesson: current)
            case .lectors:
                return LectorsViewController()
            case .timetable:
                return TimetableViewController()
            case .settings:
                return NavigationController(rootViewController: SettingsViewController())
            }
        }
    }
    
    enum RouteType {
        
        case push
        case present
    }
}
