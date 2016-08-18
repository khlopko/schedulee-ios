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
}

// MARK: - Main window

extension Router {
    
    func createMainWindow(rootViewController: ViewController?  = nil) {
        mainWindow.backgroundColor = .white
        mainWindow.rootViewController = rootViewController
        mainWindow.makeKeyAndVisible()
    }
    
    func changeRootViewController(to viewController: ViewController, animated: Bool) {
        let duration: TimeInterval = animated ? 1 : 0
        let navigation = UINavigationController(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        navigation.pushViewController(viewController, animated: false)
        navigation.setNavigationBarHidden(true, animated: false)
        UIView.transition(
            with: mainWindow,
            duration: duration,
            options: [.transitionCrossDissolve],
            animations: { self.mainWindow.rootViewController = navigation },
            completion: nil)
    }
}

extension Router {
    
    func push(route: Route, from navigation: UINavigationController?) {
        let viewController = route.viewController
        navigation?.pushViewController(viewController, animated: true)
    }
    
    func present(route: Route, from parentViewController: ViewController) {
        let viewController = route.viewController
        parentViewController.present(viewController, animated: true, completion: nil)
    }
}

extension Router {
    
    enum Route {
        
        case lessons(current: Lesson)
        case lectors
        case timetable
        
        var viewController: ViewController {
            switch self {
            case .lessons(let current):
                return LessonsViewController(currentLesson: current)
            case .lectors:
                return LectorsViewController()
            case .timetable:
                return TimetableViewController()
            }
        }
    }
}
