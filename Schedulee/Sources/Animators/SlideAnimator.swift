//
//  SlideAnimator.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/21/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import UIKit

protocol SlideViewControllerAnimatorProtocol: class {
    
    var mainView: UIView { get }
    weak var transitionView: UIView? { get }
    var expandViewBackgroundColor: UIColor? { get }
    var slideText: String? { get }
    var slideTextFont: UIFont? { get }
    var slideTextColor: UIColor? { get }
}

class SlideAnimator: NSObject {
    
    private var context: UIViewControllerContextTransitioning?
    private weak var animatingView: UIView?
    private weak var slideView: UIView?
    
    private var viewsToRemove: [UIView?] {
        return [animatingView, slideView]
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
            animations: { self.animatingView?.frame = self.container.bounds },
            completion: { _ in
                UIView.animate(
                    withDuration: self.transitionDuration(using: self.context),
                    animations: {
                        self.animatingView?.frame = self.toRect
                        self.slideView?.frame = self.toRect
                        self.toViewController.mainView.frame.origin.y = self.container.bounds.origin.y
                    },
                    completion: self.completion)
                
        })
    }
}

private extension SlideAnimator {
    
    func prepareToAnimation() {
        container.addSubview(toViewController.mainView)
        toViewController.mainView.frame = container.bounds
        toViewController.mainView.frame.origin.y = container.bounds.height
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
        self.slideView = slideLabel
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

private extension SlideAnimator {
    
    var container: UIView {
        guard let view = context?.containerView else { fatalError("Container view is nil!") }
        return view
    }
    var fromViewController: SlideViewControllerAnimatorProtocol {
        guard let viewController = context?.viewController(
            forKey: UITransitionContextFromViewControllerKey) as? SlideViewControllerAnimatorProtocol else {
                fatalError("From VC in nil!")
        }
        return viewController
    }
    var toViewController: SlideViewControllerAnimatorProtocol {
        guard let viewController = context?.viewController(
            forKey: UITransitionContextToViewControllerKey) as? SlideViewControllerAnimatorProtocol else {
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

private extension UIView {
    
    func rect(in view: UIView) -> CGRect? {
        return superview?.convert(frame, to: view)
    }
}
