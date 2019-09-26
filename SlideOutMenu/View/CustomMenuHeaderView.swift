//
//  CustomMenuHeaderView.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 8/16/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let nameLabel = UILabel()
        nameLabel.text = "Tongtong Liu"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        let userNameLabel = UILabel()
        userNameLabel.text = "@harry528tt"
        
        let statusLabel = UILabel()
        statusLabel.text = "82 followers, 10 following"
        
        let stackView = UIStackView(arrangedSubviews: [UIView(), nameLabel, userNameLabel, SpaceView(space: 16), statusLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
