//
//  InitialViewController.swift
//  CustomViewControllerTransitionsTask
//
//  Created by Robert Berry on 4/26/18.
//  Copyright © 2018 Robert Berry. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    let customInteractionAnimator = CustomInteractionAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets InitialViewController to be the delegate for the navigation controller.
        
        navigationController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Check identifier of the segue being performed.
        
        if segue.identifier == "presentMinneapolis" {
            
            let toViewController = segue.destination as UIViewController
            
            // Set the transitioningDelegate on the view controller being presented.
            
            toViewController.transitioningDelegate = self
        }
    }
    
    // MARK: Animation Methods
    
    // Method lets the view controller know which object to use for the animator.
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomPresentAnimator()
    }
    
    // Method lets the view controller know which object to use for the animator.
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomDismissAnimator()
    }
    
    // Method lets the navigation view controller know which object to use for the animator.
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let customNavigationAnimator = CustomNavigationAnimator()
        
        if operation == .push {
            
            customNavigationAnimator.pushing = true
            
            customInteractionAnimator.addToViewController(viewController: toVC)
        }
        
        return customNavigationAnimator
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerforAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        
        return customInteractionAnimator.transitionInProgress ? customInteractionAnimator : nil
    }

    


}

