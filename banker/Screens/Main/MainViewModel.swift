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
    func logout() {
        do {
            try Auth.auth().signOut()
            Router.shared.destroy()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


