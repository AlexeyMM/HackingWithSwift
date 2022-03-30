//
//  User.swift
//  Friendface
//
//  Created by Alexey Morozov on 15.03.2022.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: Int
    var company: String
    var isActive: Bool
    var about: String
    var email: String
    var registered: Date
    
    var friends: [Friend]
}
