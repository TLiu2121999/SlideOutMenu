//
//  CustomizedImageView.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 9/26/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class CustomizedImageView: UIImageView {
    
    let size: CGFloat
    
    init(size: CGFloat) {
        self.size = size
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: size, height: size)
    }
    
}
