//
//  PositionButton.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class PositionButton: UIButton {
    
    init(title: String) {
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightThin)
        
        self.backgroundColor = Cons.control.buttonColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = Cons.control.highlightedColor
            } else {
                self.backgroundColor = Cons.control.buttonColor
            }
        }
    }
    
}
