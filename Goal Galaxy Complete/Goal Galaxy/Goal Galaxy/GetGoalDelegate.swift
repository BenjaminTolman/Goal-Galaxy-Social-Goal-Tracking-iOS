//
//  GetGoalDelegate.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/19/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation

protocol GetGoalDelegate {
    func getGoal(goal: Goal, delete: Bool, complete: Bool)
}
