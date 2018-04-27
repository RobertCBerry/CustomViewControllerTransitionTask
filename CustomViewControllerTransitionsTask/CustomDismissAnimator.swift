//
//  CustomDismissAnimator.swift
//  CustomViewControllerTransitionsTask
//
//  Created by Robert Berry on 4/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class CustomDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Method asks animator object for the duration in seconds of the transition animation.
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 1
    }
    
    // Method tells animator object to perform the transition animations.
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Retrieves references to the view controller were transitioning into and out of, and the container view which is the view in which the animated transition should take place.
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            
            return
        }
        
        var fromViewControllerEndFrame = fromViewController.view.frame
        
        fromViewControllerEndFrame.origin.y -= UIScreen.main.bounds.height
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        transitionContext.containerView.sendSubview(toBack: toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            fromViewController.view.frame = fromViewControllerEndFrame
            
            toViewController.view.alpha = 1
            
        }, completion: {
            
            completed in transitionContext.completeTransition(true)
        })
    }

}
