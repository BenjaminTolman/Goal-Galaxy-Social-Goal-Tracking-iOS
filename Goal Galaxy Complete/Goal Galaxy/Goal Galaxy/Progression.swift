//
//  Progression.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/20/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//

import Foundation

class Progression{
    
    //Stored properties.
    var id: Int
    var name: String
    var note: String
    var date: String
    
    //Initialization.
    init(name: String, note: String, date: String, id: Int){
        self.id = id
        self.name = name
        self.note = note
        self.date = date
    }
}
