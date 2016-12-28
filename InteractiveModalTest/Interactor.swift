//
//  Interactor.swift
//  InteractiveModalTest
//
//  Created by Yan Malinovsky on 28.12.16.
//  Copyright © 2016 Yan Malinovsky. All rights reserved.
//

import Foundation
import UIKit

class Interactor: UIPercentDrivenInteractiveTransition {
    var hasStarted = false // Indicates whether an interaction is underway.
    var shouldFinish = false // Determines whether the interaction should complete, or roll back.
}
