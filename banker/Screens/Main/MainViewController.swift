//
//  MainViewController.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Palette.bg
        
        initMarkup()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.rooms.bind { [weak self] rooms in
            self?.collectionView.reloadData()
            self?.refreshControl.endRefreshing()
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
        view.backgroundColor = UIColor(patternImage: Theme.bgImage)
        
        // Logout button
        var buttonConfig = UIButton.Configuration.plain()
        let iconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 14, weight: .bold))
        buttonConfig.image = UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: iconConfig)
        buttonConfig.baseForegroundColor = .white
        let button = UIButton()
        button.configuration = buttonConfig
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Heading
        let heading = Typography.navHeading("My Rooms")
        heading.textColor = .white
        
        let contentWrapper = UIView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.backgroundColor = .white
        contentWrapper.clipsToBounds = true
        contentWrapper.layer.cornerRadius = 32
        contentWrapper.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        let grid = UIView()
        grid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(grid)
        view.addSubview(heading)
        view.addSubview(button)
        
        // Collection view
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(RoomCell.self, forCellWithReuseIdentifier: "roomCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = refreshControl
        collectionView.showsVerticalScrollIndicator = false
        self.collectionView = collectionView
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // Button
        var addButtonConfig = UIButton.Configuration.filled()
        let addIconConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .bold))
        addButtonConfig.image = UIImage(systemName: "plus", withConfiguration: addIconConfig)
        addButtonConfig.baseForegroundColor = .white
        addButtonConfig.baseBackgroundColor = .black
        addButtonConfig.cornerStyle = .capsule
        addButtonConfig.buttonSize = .large

        let addButton = UIButton()
        addButton.configuration = addButtonConfig
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        grid.addSubview(contentWrapper)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            // Grid
            grid.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 32),
            grid.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -32),
            grid.topAnchor.constraint(equalTo: guide.topAnchor),
            grid.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            // Content wrapper
            contentWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentWrapper.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentWrapper.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentWrapper.topAnchor.constraint(equalTo: guide.topAnchor, constant: 80),
            // Navbar
            button.topAnchor.constraint(equalTo: grid.topAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: grid.rightAnchor, constant: 10),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
            heading.leftAnchor.constraint(equalTo: grid.leftAnchor),
            heading.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            heading.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor),
            // Collection view
            collectionView.leftAnchor.constraint(equalTo: grid.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: grid.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: contentWrapper.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
            // Add Button
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: grid.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func onButtonTap(_ sender: UIButton) {
        viewModel.logout()
    }
    
    @objc private func refreshData(_ sender: Any) {
        viewModel.load()
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.rooms.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "roomCell", for: indexPath
        ) as! RoomCell
        let room = viewModel.rooms.value[indexPath.row]
        cell.room = room
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 64, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }
}

//extension MainViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//            return true
//        }
//}
