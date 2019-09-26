//
//  MenuItemCell.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 9/26/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    let iconImageView: CustomizedImageView = {
        let iconView = CustomizedImageView(size: 36)
        iconView.contentMode = .scaleAspectFit
        iconView.image = #imageLiteral(resourceName: "light")
        return iconView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            label,
            UIView()])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 12, bottom: 15, right: 12)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
            ])
    }
    
}
