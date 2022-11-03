//
//  Transaction.swift
//  banker
//
//  Created by Artyom Ivanov on 03.11.2022.
//

import Foundation

struct Transaction {
    let id: String
    let amount: Double
    let createdAt: Date
    let source: String?
    let destination: String?
}
