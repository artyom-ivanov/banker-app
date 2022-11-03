//
//  Room.swift
//  banker
//
//  Created by Artyom Ivanov on 03.11.2022.
//

import Foundation

struct Room {
    let id: String
    let code: String
    let createdAt: Date
    let author: User
    var updatedAt: Date
    var transactions: [Transaction]
    var members: [User]
    var lastActivity: [UserId: Date]
}
