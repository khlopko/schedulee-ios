//
//  SplashViewController.swift
//  Schedulee
//
//  Created on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit
import Tools

final class SplashViewController: ViewController {

    private var contentView: SplashView {
        return view as! SplashView
    }
    
    private let duration: TimeInterval = 0.5
    private let delay: TimeInterval = 0.25
    private var verticalLinesAnimated = 0 {
        didSet {
            if verticalLinesAnimated == verticalLines.count {
                animateHorizontalLines()
            }
        }
    }
    private var horizontalLinesAnimated = 0 {
        didSet {
            if horizontalLinesAnimated == horizontalLines.count {
                finalAnimation()
            }
        }
    }
    
    override func loadView() {
        view = SplashView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Animations
    
    private func startAnimation() {
        animateVerticalLines()
    }
    
    private func animateVerticalLines() {
        var delay: TimeInterval = 0
        for line in verticalLines {
            animate(
                line: line,
                delay: delay,
                animation: { line.frame.size.height = self.view.bounds.height },
                completion: { self.verticalLinesAnimated += 1 })
            delay += self.delay
        }
    }
    
    private func animateHorizontalLines() {
        var delay: TimeInterval = 0
        for line in horizontalLines {
            animate(
                line: line,
                delay: delay,
                animation: { line.frame.size.width = self.view.bounds.width },
                completion: { self.horizontalLinesAnimated += 1 })
            delay += self.delay
        }
    }
    
    private func animate(line: UIView,
                 delay: TimeInterval,
                 animation: @escaping () -> (),
                 completion: @escaping () -> ()) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [.curveEaseInOut],
            animations: { animation() },
            completion: { finished in
                if finished {
                    completion()
                }
        })
    }
    
    private func finalAnimation() {
        UIView.animate(
            withDuration: 0.75,
            delay: self.delay,
            options: [.curveEaseInOut],
            animations: {
                self.verticalLines.forEach {
                    $0.frame.size.width = 1000
                    $0.frame.origin.x = 0
                }
                self.horizontalLines.forEach {
                    $0.frame.size.height = 1000
                    $0.frame.origin.y = 0
                }
            }, completion: { finished in
                if finished {
                    let viewController = UserSettings.default.currentGroupID == 0
                        ? SelectGroupViewController()
                        : HomeViewController()
                    self.router?.changeRootViewController(to: viewController, animated: true)
                }
        })
    }

    // MARK: - Computed properties
    
    private var verticalLines: [UIView] {
        return contentView.verticalLines
    }
    private var horizontalLines: [UIView] {
        return contentView.horizontalLines
    }
}
