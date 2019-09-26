//
//  SpaceView.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 9/26/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class SpaceView: UIView {
    let space: CGFloat
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }

}
