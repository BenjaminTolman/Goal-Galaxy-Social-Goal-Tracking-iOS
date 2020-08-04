//
//  Goal.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/18/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation

class Goal{
    
    //Stored properties.
    var id: String
    var name: String
    var date: String
    var desc: String
    var completed: String
    var progressions: [Progression]?
    
    //Initialization.
    init(id: String, name: String, desc: String, date: String, progressions: [Progression], completed: String) {
        self.name = name
        self.date = date
        self.desc = desc
        self.id = id
        self.progressions = progressions
        self.completed = completed
    }
}
