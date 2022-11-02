//
//  LoginViewModel.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import FirebaseAuth
import UIKit.UIButton

final class LoginViewModel {
    var isLoading: Binder<Bool> = Binder(false)
    
    func login() {
        isLoading.value = true
        Auth.auth().signInAnonymously { authResult, error in
            self.isLoading.value = false
            Router.shared.route(to: .Main, from: .Login)
        }
    }
}
