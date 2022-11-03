//
//  User.swift
//  banker
//
//  Created by Artyom Ivanov on 03.11.2022.
//

import Foundation

typealias UserId = String

struct User {
    let id: UserId
    let name: String
    let createdAt: Date
}
