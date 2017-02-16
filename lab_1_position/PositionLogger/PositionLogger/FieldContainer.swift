//
//  FieldContainer.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/16/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class FieldContainer: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
