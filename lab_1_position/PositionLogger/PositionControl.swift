//
//  PositionControl.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class PositionControl: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = .zero
        
        self.backgroundColor = Cons.control.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
