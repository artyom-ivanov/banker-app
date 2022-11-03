//
//  MainViewModel.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import FirebaseAuth

protocol MainViewModelInterface {
    func logout()
}

final class MainViewModel: MainViewModelInterface {
    var rooms: Binder<[Room]> = Binder([
        Room(
            id: "AB12AS",
            code: "AB12AS",
            createdAt: Date(),
            author: User(id: "a", name: "Artyom Ivanov", createdAt: Date()),
            updatedAt: Date(),
            transactions: [],
            members: [
                User(id: "a", name: "Artyom Ivanov", createdAt: Date()),
                User(id: "b", name: "Michael Sergeev", createdAt: Date()),
                User(id: "c", name: "Ivan Korchenko", createdAt: Date())
            ],
            lastActivity: [
                "a": Date(),
                "b": Date(timeIntervalSinceNow: -60),
                "c": Date(timeIntervalSinceNow: -3600),
            ]
        ),
        Room(
            id: "DS45JJ",
            code: "DS45JJ",
            createdAt: Date(timeIntervalSinceNow: -3600*40),
            author: User(id: "a", name: "Artyom Ivanov", createdAt: Date()),
            updatedAt: Date(),
            transactions: [],
            members: [
                User(id: "a", name: "Artyom Ivanov", createdAt: Date()),
                User(id: "c", name: "Ivan Korchenko", createdAt: Date())
            ],
            lastActivity: [
                "c": Date(),
                "a": Date(timeIntervalSinceNow: -60),
            ]
        ),
    ])
    
    func load() {
        // Load from network
        rooms.value.append(
            Room(
                id: "NEWROOM",
                code: "NEWROOM",
                createdAt: Date(timeIntervalSinceNow: -3600*40),
                author: User(id: "a", name: "Artyom Ivanov", createdAt: Date()),
                updatedAt: Date(),
                transactions: [],
                members: [
                    User(id: "a", name: "Artyom Ivanov", createdAt: Date()),
                ],
                lastActivity: [
                    "a": Date(timeIntervalSinceNow: -60),
                ]
            )
        )
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            Router.shared.destroy()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


