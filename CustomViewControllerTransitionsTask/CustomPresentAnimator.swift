//
//  CustomPresentAnimator.swift
//  CustomViewControllerTransitionsTask
//
//  Created by Robert Berry on 4/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class CustomPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        
        // Returns the ending frame rectangle for the specified view controller’s view.
        
        let toViewControllerEndFrame = transitionContext.finalFrame(for: toViewController)
        
        var toViewControllerStartFrame = toViewControllerEndFrame
        
        toViewControllerStartFrame.origin.y -= UIScreen.main.bounds.height
        
        toViewController.view.frame = toViewControllerStartFrame
        
        // Adds the view of the view controller that we're transitioning to into the container view.
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            
            toViewController.view.frame = toViewControllerEndFrame
            
            // Code makes fromViewController darker while transition occurs into the new view.
            
            fromViewController.view.alpha = 0.5
            
        }, completion: {
            
            // Notifies the system that the transition animation is done.
            
            completed in transitionContext.completeTransition(true)
        })
    }
}
