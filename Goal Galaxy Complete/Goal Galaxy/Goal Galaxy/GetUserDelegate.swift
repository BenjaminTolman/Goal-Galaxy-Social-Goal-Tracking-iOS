//
//  GetUserDelegate.swift
//  Goal Galaxy
//
//  Created by Benjamin Tolman on 7/24/20.
//  Copyright © 2020 Benjamin Tolman. All rights reserved.
//
import Foundation

protocol GetUserDelegate {
    func getUser(user: User, unfollow: Bool)
}
