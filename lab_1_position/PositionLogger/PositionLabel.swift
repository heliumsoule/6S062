//
//  PositionLabel.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class PositionLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textAlignment = .center
        self.font = Cons.positionLabel.font
        self.textColor = Cons.positionLabel.textColor
        self.numberOfLines = Cons.positionLabel.nLines
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
