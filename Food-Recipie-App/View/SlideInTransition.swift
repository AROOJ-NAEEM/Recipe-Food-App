//
//  SlideInTransition.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        let width = containerView.bounds.width
        toView.frame.origin.x = -width
        toView.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.frame.origin.x = 0
            toView.alpha = 1.0
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

}
