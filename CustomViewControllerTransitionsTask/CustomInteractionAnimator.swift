//
//  CustomInteractionAnimator.swift
//  CustomViewControllerTransitionsTask
//
//  Created by Robert Berry on 4/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class CustomInteractionAnimator: UIPercentDrivenInteractiveTransition {
    
    private var navigationController: UINavigationController!
    
    // Variable to represent if the transition should be completed.
    
    private var shouldCompleteTransition = false
    
    // Variable to represent if there is a transition in progress.
    
    var transitionInProgress = false
    
    func addToViewController(viewController: UIViewController) {
        
        navigationController = viewController.navigationController
        
        addGestureRecognizer(view: viewController.view)
        
    }
    
    private func addGestureRecognizer(view: UIView) {
        
        // Attaches a gesture recognizer to the view.
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(CustomInteractionAnimator.handlePanGesture(gestureRecognizer:))))
    }
    
    // Method handles the callbacks of the gesture recognizer.
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translatedPoint = gestureRecognizer.translation(in: gestureRecognizer.view!.superview);
        
        // Calculates the percentage of the pan gesture by checking how much the gesture has moved on the x-axis and dividing that by the total width of the view.
        
        let progress = translatedPoint.x / (gestureRecognizer.view!.superview?.frame.size.width)!
        
        switch gestureRecognizer.state {
            
        case .began:
            
            transitionInProgress = true
            
            navigationController.popViewController(animated: true)
            
        case .changed:
            
            // If the process has completed more than 50% of the pan gesture, than the transition should be completed.
            
            shouldCompleteTransition = progress > 0.5
            
            // Updates the completion percentage of the transition.
            
            update(progress)
            
        case .cancelled, .ended:
            
            transitionInProgress = false
            
            if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                
                // Notifies the system that user actions cancelled the transition.
                
                cancel()
                
            } else {
                
                // Notifies the system that user actions completed the transition.
                
                finish()
            }
            
        default:
            
            break
        }
    }

}
