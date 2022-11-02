//
//  Theme.swift
//  banker
//
//  Created by Artyom Ivanov on 02.11.2022.
//

import UIKit.UILabel

struct Typography {
    static func heading(_ text: String) -> UILabel {
        let heading = UILabel()
        heading.text = text
        heading.font = UIFont.boldSystemFont(ofSize: 48)
        
        heading.translatesAutoresizingMaskIntoConstraints = false
        return heading
    }
    
    static func body(_ text: String) -> UILabel {
        let body = UILabel()
        body.text = text
        body.font = UIFont.preferredFont(forTextStyle: .body)
        body.lineBreakMode = .byWordWrapping
        body.numberOfLines = 0
        body.translatesAutoresizingMaskIntoConstraints = false
        return body
    }
}
