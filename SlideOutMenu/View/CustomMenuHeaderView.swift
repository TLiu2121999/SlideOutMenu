//
//  CustomMenuHeaderView.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 8/16/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    let nameLabel = UILabel()
    let userNameLabel = UILabel()
    let statusLabel = UILabel()
    let profileImageView = CustomizedImageView(size: 48)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        setupLabels()
        
        setupProfileImage()
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [profileImageView, UIView()]),
            nameLabel,
            userNameLabel,
            SpaceView(space: 16),
            statusLabel
            ])
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
    
    fileprivate func setupLabels() {
        nameLabel.text = "Tongtong Liu"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        userNameLabel.text = "@harry528tt"        
        setAttributedText()
    }
    
    fileprivate func setupProfileImage() {
        let profileImage = UIImage(named: "flora")

        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = 24
        profileImageView.clipsToBounds = true
        profileImageView.image = profileImage
    }
    
    fileprivate func setAttributedText() {
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSMutableAttributedString(string:"Following, ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)]))
        attributedText.append(NSMutableAttributedString(string:"100 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)]))
        attributedText.append(NSMutableAttributedString(string:"Followers ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)]))
        statusLabel.attributedText = attributedText
    }
}
