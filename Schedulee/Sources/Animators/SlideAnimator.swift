//
//  SlideAnimator.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/21/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

// MARK: - SlideViewControllerAnimatorProtocol

protocol SlideViewControllerAnimatorProtocol: class {
    
    var mainView: UIView { get }
    weak var transitionView: UIView? { get }
    var expandViewBackgroundColor: UIColor? { get }
    var slideText: String? { get }
    var slideTextFont: UIFont? { get }
    var slideTextColor: UIColor? { get }
}

// MARK: - SlideAnimator

class SlideAnimator: NSObject {
    
    fileprivate var context: UIViewControllerContextTransitioning?
    fileprivate weak var animatingView: UIView?
    fileprivate weak var slideLabel: UILabel?
    
    fileprivate var viewsToRemove: [UIView?] {
        return [animatingView, slideLabel]
    }
}

// MARK: - AnimatorProtocol

extension SlideAnimator: AnimatorProtocol {
    
    func validate(from fromViewController: UIViewController, to toViewController: UIViewController) -> Bool {
        return
            fromViewController is SlideViewControllerAnimatorProtocol &&
            toViewController is SlideViewControllerAnimatorProtocol
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension SlideAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        prepareToAnimation()
        UIView.animate(
            withDuration: transitionDuration(using: context),
            animations: {
                self.animatingView?.frame = self.container.bounds
                self.slideLabel?.font = self.toViewController.slideTextFont
            },
            completion: { _ in
                self.toViewController.mainView.alpha = 1
                UIView.animate(
                    withDuration: self.transitionDuration(using: self.context),
                    animations: {
                        self.animatingView?.frame = self.toRect
                        self.slideLabel?.frame = self.toRect
                    },
                    completion: self.completion)
                
        })
    }
}

// MARK: - Private support

fileprivate extension SlideAnimator {
    
    func prepareToAnimation() {
        container.addSubview(toViewController.mainView)
        toViewController.mainView.frame = container.bounds
        toViewController.mainView.alpha = 0
        toViewController.mainView.layoutIfNeeded()
        toViewController.transitionView?.isHidden = true
        fromViewController.transitionView?.isHidden = true
        let (expand, slide) = makeAnimationViews()
        container.addSubview(expand)
        container.addSubview(slide)
        container.backgroundColor = expand.backgroundColor
    }
    
    func makeAnimationViews() -> (expand: UIView, slide: UIView) {
        let expandView = UIView(frame: fromRect)
        expandView.backgroundColor = fromViewController.expandViewBackgroundColor
        let slideLabel = UILabel(frame: fromRect)
        slideLabel.text = fromViewController.slideText
        slideLabel.font = fromViewController.slideTextFont
        slideLabel.textColor = fromViewController.slideTextColor
        slideLabel.textAlignment = .center
        self.slideLabel = slideLabel
        self.animatingView = expandView
        return (expandView, slideLabel)
    }
    
    func completion(_: Bool) {
        guard let context = context else { return }
        let isCancelled = context.transitionWasCancelled
        context.completeTransition(!isCancelled)
        viewsToRemove.forEach { $0?.removeFromSuperview() }
        toViewController.transitionView?.isHidden = false
        fromViewController.transitionView?.isHidden = false
    }
}

// MARK: - Private computed properties

fileprivate extension SlideAnimator {
    
    var container: UIView {
        guard let view = context?.containerView else { fatalError("Container view is nil!") }
        return view
    }
    var fromViewController: SlideViewControllerAnimatorProtocol {
        guard let viewController = context?.viewController(
            forKey: UITransitionContextViewControllerKey.from) as? SlideViewControllerAnimatorProtocol else {
                fatalError("From VC in nil!")
        }
        return viewController
    }
    var toViewController: SlideViewControllerAnimatorProtocol {
        guard let viewController = context?.viewController(
            forKey: UITransitionContextViewControllerKey.to) as? SlideViewControllerAnimatorProtocol else {
                fatalError("To VC in nil!")
        }
        return viewController
    }
    var fromRect: CGRect {
        return fromViewController.transitionView?.rect(in: container) ?? .zero
    }
    var toRect: CGRect {
        return toViewController.transitionView?.rect(in: container) ?? .zero
    }
}

// MARK: - Private UIView extension

fileprivate extension UIView {
    
    func rect(in view: UIView) -> CGRect? {
        return superview?.convert(frame, to: view)
    }
}
