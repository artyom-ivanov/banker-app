//
//  LoaderViewController.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import UIKit

class LoaderViewController: UIViewController {
    
    let viewModel = LoaderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.bg
        navigationController?.setNavigationBarHidden(true, animated: false)
        initMarkup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.listenLogin()
    }
    
    func initMarkup() {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        
        self.view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
}
