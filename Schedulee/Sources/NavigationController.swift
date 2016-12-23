//
//  NavigationControllerViewController.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    fileprivate let slideAnimator = SlideAnimator()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return viewControllers.last?.preferredStatusBarStyle ?? .default
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        delegate = self
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        router?.currentNavigation = self
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if slideAnimator.validate(from: fromVC, to: toVC) {
            return slideAnimator
        }
        return nil
    }
}
