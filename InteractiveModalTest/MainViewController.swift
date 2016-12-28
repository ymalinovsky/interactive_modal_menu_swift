//
//  MainViewController.swift
//  InteractiveModalTest
//
//  Created by Yan Malinovsky on 28.12.16.
//  Copyright © 2016 Yan Malinovsky. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // Create interactor object
    let interactor = Interactor()

    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    // All of this code is essentially trying to update the transition status each time a pan gesture event is fired.
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        // Get the pan gesture coordinates.
        let translation = sender.translation(in: view)
        
        // Using the MenuHelper‘s calculateProgress() method, you convert the coordinates into progress in a specific direction
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
        
        // Pass all the information to the MenuHelper‘s mapGestureStateToInteractor() method. This does the hard work of syncing the gesture state with the interactive transition.
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            // Pass the interactor object forward
            destinationViewController.interactor = interactor
        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    // You indicate that the dismiss transition is going to be interactive, but only if the user is panning. (Remember that hasStarted was set to true when the pan gesture began.)
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}
