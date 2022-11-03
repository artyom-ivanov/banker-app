//
//  RoomCell.swift
//  banker
//
//  Created by Artyom Ivanov on 03.11.2022.
//

import UIKit

class RoomCell: UICollectionViewCell {
    var room: Room? {
        didSet {
            guard let data = room else { return }
            
            let roomName = UILabel(
                frame: CGRect(
                    x: 20,
                    y: 20,
                    width: contentView.frame.width - 40,
                    height: 30
                )
            )
            
            roomName.text = data.code
            roomName.font = UIFont.boldSystemFont(ofSize: 20)
            
            data.members.enumerated().forEach { (index, member) in
                let xPosition = Int(contentView.frame.width) - 40 - (data.members.count - index) * 16
                
                let memberLabel = UILabel(
                    frame: CGRect(
                        x: xPosition,
                        y: 80,
                        width: 32,
                        height: 32
                    )
                )
                memberLabel.backgroundColor = .white
                memberLabel.layer.borderWidth = 1
                memberLabel.layer.cornerRadius = 16
                memberLabel.clipsToBounds = true
                memberLabel.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
                contentView.addSubview(memberLabel)
            }
            
            
            contentView.addSubview(roomName)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        contentView.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
