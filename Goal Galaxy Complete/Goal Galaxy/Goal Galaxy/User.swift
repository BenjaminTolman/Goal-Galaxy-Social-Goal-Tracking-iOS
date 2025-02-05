//
//  User.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/23/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation
class User
{
    //Stored properties.
    var name: String
    var goals: [Goal]?
    var followedUsers : [User]
    
    //Initialization.
    init(name: String, goals: [Goal], followedUsers: [User]){
        self.name = name
        self.goals = goals
        self.followedUsers = followedUsers
    }
}
