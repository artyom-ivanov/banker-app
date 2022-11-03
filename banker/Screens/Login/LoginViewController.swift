//
//  Login.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    var signInButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Palette.bg
        
        initMarkup()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            self?.signInButton?.isUserInteractionEnabled = !isLoading
            self?.signInButton?.configuration?.showsActivityIndicator = isLoading
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initMarkup() {
        // Background
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Theme.bgImage
        imageView.center = view.center
        view.addSubview(imageView)
        
        // Grid
        let guide = view.safeAreaLayoutGuide
        
        let grid = UIView()
        grid.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(grid)
        
        // Content
        let handIcon = NSTextAttachment()
        handIcon.image = UIImage(systemName: "hand.wave")?.withTintColor(.white)
        handIcon.bounds = CGRect(x: 0, y: 0, width: 36, height: 36)
        
        let headingString = NSMutableAttributedString(string: "Hello! ")
        headingString.append(NSAttributedString(attachment: handIcon))
        
        let heading = Typography.heading("")
        heading.attributedText = headingString
        let body1 = Typography.body("It’s a banker — app for fake payments between closed groups.")
        let body2 = Typography.body("For example, if you are going to play table monopoly with your friends, but all paper money has been lost. Create a room, invite your friends and use your phones as wallets.")
        
        heading.textColor = .white
        body1.textColor = .white
        body2.textColor = .white
        
        let contentWraper = UIView()
        contentWraper.translatesAutoresizingMaskIntoConstraints = false
        contentWraper.addSubview(heading)
        contentWraper.addSubview(body1)
        contentWraper.addSubview(body2)
        
        // Button
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.baseBackgroundColor = .white
        
        buttonConfig.imagePadding = 12
        buttonConfig.title = "Sign in with Apple"
        buttonConfig.attributedTitle = AttributedString("Sign in with Apple", attributes: container)
        buttonConfig.image = UIImage(systemName: "apple.logo")
        buttonConfig.baseForegroundColor = .black
        buttonConfig.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = buttonConfig
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton = button
        
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
            body1.widthAnchor.constraint(equalTo: contentWraper.widthAnchor),
            body2.widthAnchor.constraint(equalTo: contentWraper.widthAnchor),
            heading.topAnchor.constraint(equalTo: contentWraper.topAnchor),
            body1.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 12),
            body2.topAnchor.constraint(equalTo: body1.bottomAnchor, constant: 12),
            button.leftAnchor.constraint(equalTo: grid.leftAnchor),
            button.rightAnchor.constraint(equalTo: grid.rightAnchor),
            button.bottomAnchor.constraint(equalTo: grid.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 56),
            body2.bottomAnchor.constraint(equalTo: contentWraper.bottomAnchor)
        ])
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        viewModel.login()
    }    
    
}
