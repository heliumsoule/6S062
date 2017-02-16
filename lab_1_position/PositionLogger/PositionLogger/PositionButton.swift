//
//  PositionButton.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/16/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class PositionButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = Cons.controls.tintColor
        
        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = Cons.controls.highlightedColor
            } else {
                self.backgroundColor = Cons.controls.defaultColor
            }
        }
    }
    
}
