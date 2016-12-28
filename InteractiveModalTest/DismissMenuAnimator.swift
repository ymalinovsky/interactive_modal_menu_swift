//
//  DismissMenuAnimator.swift
//  InteractiveModalTest
//
//  Created by Yan Malinovsky on 28.12.16.
//  Copyright © 2016 Yan Malinovsky. All rights reserved.
//

import Foundation
import UIKit

// Take advantage of the NSObjectProtocol.
class DismissMenuAnimator : NSObject {
}

// This protocol implements the animation for a custom view controller transition.
extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    
    // This method determines how long the animation lasts.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
        // This method is where you define the custom animation. It gives you access to the two View Controllers involved in the transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            // This is the MenuViewController
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            // This is the MainViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        // Think of this as the Window or main screen
        let containerView = transitionContext.containerView
        
        // The first step is to get a handle of this snapshot view. Luckily, you tagged the snapshot in an earlier step, so you can retrieve it using viewWithTag().
        let snapshot: UIView = containerView.viewWithTag(MenuHelper.snapshotNumber)!
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                // The animation moves the snapshot back to the center of the screen.
                snapshot.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    // If the animation finishes, replace the snapshot with the real thing.
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
        }
        )
    }
}
