//
//  MenuViewController.swift
//  InteractiveModalTest
//
//  Created by Yan Malinovsky on 28.12.16.
//  Copyright © 2016 Yan Malinovsky. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // The MainViewController passes the interactor object to the MenuViewController. This is how they share state.
    var interactor:Interactor? = nil
    
    // All of this code is essentially trying to update the transition status each time a pan gesture event is fired.
    @IBAction func handleGesture(sender: UIPanGestureRecognizer) {
        
        // Get the pan gesture coordinates.
        let translation = sender.translation(in: view)
        // Using the MenuHelper‘s calculateProgress() method, you convert the coordinates into progress in a specific direction
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .Left
        )
        // Pass all the information to the MenuHelper‘s mapGestureStateToInteractor() method. This does the hard work of syncing the gesture state with the interactive transition.
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
