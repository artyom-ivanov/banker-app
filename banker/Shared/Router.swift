//
//  Router.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import UIKit.UINavigationController
import UIKit.UIViewController

enum Screens {
    case Login
    case Main
    case Loader
}

final class Router {
    
    static let shared = Router()
    
    private let routes: [Screens: UIViewController] = [
        .Login: LoginViewController(),
        .Main: MainViewController()
    ]
    
    var navigation: UINavigationController?
    
    private init() {
        let navigation = UINavigationController()
        navigation.viewControllers = [
            LoaderViewController()
        ]
        self.navigation = navigation
    }
    
    func destroy() {
        navigation?.popToRootViewController(animated: false)
    }

    func route(to destination: Screens, from: Screens) {
        guard let destinationVC = routes[destination] else {
           return
        }
        
        if from == .Loader {
            navigation?.pushViewController(destinationVC, animated: true)
        }
        
        if destination == .Main && from == .Login {
            navigation?.pushViewController(destinationVC, animated: true)
        }
    }
}
