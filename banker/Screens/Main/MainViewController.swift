//
//  MainViewController.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Palette.bg
        
        initMarkup()
    }
    
    func initMarkup() {
        // Grid
        let guide = view.safeAreaLayoutGuide
        
        let grid = UIView()
        grid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(grid)
        
        // Content
        let heading = Typography.heading("Logged")
        let body = Typography.body("Nice, you are logged in")
               
        var buttonConfig = UIButton.Configuration.tinted()
        buttonConfig.image = UIImage(systemName: "door.right.hand.open")
        buttonConfig.cornerStyle = .capsule
        buttonConfig.buttonSize = .mini
        
        let button = UIButton()
        button.configuration = buttonConfig
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let contentWraper = UIView()
        contentWraper.translatesAutoresizingMaskIntoConstraints = false
        contentWraper.addSubview(heading)
        contentWraper.addSubview(body)
        
        grid.addSubview(contentWraper)
        grid.addSubview(button)
        
        NSLayoutConstraint.activate([
            // Grid
            grid.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 32),
            grid.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -32),
            grid.topAnchor.constraint(equalTo: guide.topAnchor),
            grid.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            // Content wrapper
            contentWraper.centerYAnchor.constraint(equalTo: grid.centerYAnchor),
            contentWraper.leftAnchor.constraint(equalTo: grid.leftAnchor),
            contentWraper.rightAnchor.constraint(equalTo: grid.rightAnchor),
            // Elements
            heading.widthAnchor.constraint(equalTo: contentWraper.widthAnchor),
            body.widthAnchor.constraint(equalTo: contentWraper.widthAnchor),
            heading.topAnchor.constraint(equalTo: contentWraper.topAnchor),
            body.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 12),
            body.bottomAnchor.constraint(equalTo: contentWraper.bottomAnchor),
            button.topAnchor.constraint(equalTo: grid.topAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: grid.rightAnchor),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        viewModel.logout()
    }
    
}

//extension MainViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//            return true
//        }
//}
