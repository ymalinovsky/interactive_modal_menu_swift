//
//  PresentMenuAnimator.swift
//  InteractiveModalTest
//
//  Created by Yan Malinovsky on 28.12.16.
//  Copyright © 2016 Yan Malinovsky. All rights reserved.
//

import Foundation
import UIKit

// Take advantage of the NSObjectProtocol.
class PresentMenuAnimator : NSObject {
}

// This protocol implements the animation for a custom view controller transition.
extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
    
    // This method determines how long the animation lasts.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    // This method is where you define the custom animation. It gives you access to the two View Controllers involved in the transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            // This is the MainViewController
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            // This is the MenuViewController
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        
        // Think of this as the Window or main screen
        let containerView = transitionContext.containerView
        
        // This inserts the MenuViewController behind the MainViewController.
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        /* Replace main view with snapshot:
            - Create snapshot of the MainViewController. This serves two purposes:
                * The snapshot is just an image, so the user can’t accidentally interact with it.
                * Since the fromVC automatically gets removed after the transition, the snapshot gives the illusion that it’s still on the screen.
            - There’s a few other things you do to the snapshot:
                * tag: Serves as a handle you’ll use to remove the snapshot later on.
                * userInteractionEnabled: You set this to false so you can tap objects behind the snapshot. This becomes useful in a later step.
                * shadowOpacity: This is a visual cue that the snapshot floats above the menu.
        */
        let snapshot: UIView = fromVC.view.snapshotView(afterScreenUpdates: false)!
        snapshot.tag = MenuHelper.snapshotNumber
        snapshot.isUserInteractionEnabled = false
        snapshot.layer.shadowOpacity = 0.7
        containerView.insertSubview(snapshot, aboveSubview: toVC.view)
        fromVC.view.isHidden = true
        
        UIView.animate(
            // The animation duration is set to 0.6 seconds.
            withDuration: transitionDuration(using: transitionContext),
            
            // The snapshot is shifted to the right by 80% of the screen’s width.
            animations: {
                snapshot.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
        },
            // Set the MainViewController hidden state back to normal, so that it’s ready for next time.
            completion: { _ in
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
}
