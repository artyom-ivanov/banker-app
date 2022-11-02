//
//  LoaderViewModel.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import FirebaseAuth

protocol LoaderViewModelInterface {
    func listenLogin()
}

final class LoaderViewModel: LoaderViewModelInterface {
    func listenLogin() {
        if Auth.auth().currentUser != nil {
            Router.shared.route(to: .Main, from: .Loader)
        } else {
            Router.shared.route(to: .Login, from: .Loader)
        }
    }
}

