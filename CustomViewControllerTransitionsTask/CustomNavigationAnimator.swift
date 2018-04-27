//
//  CustomNavigationAnimator.swift
//  CustomViewControllerTransitionsTask
//
//  Created by Robert Berry on 4/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class CustomNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Properties
    
    var pushing = false
    
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
        
        if pushing {
            
            toViewControllerStartFrame.origin.y -= UIScreen.main.bounds.height
        }
        
        toViewController.view.frame = toViewControllerStartFrame
        
        // Adds the view of the view controller that we're transitioning to into the container view.
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        transitionContext.containerView.sendSubview(toBack: toViewController.view)
        
        let snapshotView: UIView
        
        let snapshotViewFinalFrame: CGRect
        
        if (pushing) {
            
            snapshotView = toViewController.view.snapshotView(afterScreenUpdates: true)!
            
            snapshotView.frame = (fromViewController.view.frame).insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2)
            
            snapshotViewFinalFrame = toViewControllerEndFrame
            
        } else {
            
            snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false)!
            
            snapshotView.frame = fromViewController.view.frame
            
            snapshotViewFinalFrame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width / 2, dy: fromViewController.view.frame.size.height / 2)
            
            fromViewController.view.isHidden = true
        }
        
        transitionContext.containerView.addSubview(snapshotView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            snapshotView.frame = snapshotViewFinalFrame
            
        }, completion: {
            
            finished in let cancelled = transitionContext.transitionWasCancelled
            
            if self.pushing {
                
                toViewController.view.frame = toViewControllerEndFrame
                
            } else if cancelled {
                
                fromViewController.view.isHidden = false
            }
            
            // Remove the snapshotView when the animation is complete, so that users can interact with the view controller itself.
            
            snapshotView.removeFromSuperview()
            
            transitionContext.completeTransition(!cancelled)
            
        })
    }
}
