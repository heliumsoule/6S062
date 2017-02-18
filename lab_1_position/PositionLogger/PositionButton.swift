//
//  PositionButton.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class PositionButton: UIButton {
    
    var controlDelegate:PositionControlDelegate!
    let index:Int
    
    init(title: String, index: Int) {
        self.index = index
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightThin)
        
        self.addTarget(self, action: #selector(PositionButton.changeStateCallback), for: .touchUpInside)        
        self.backgroundColor = Cons.control.buttonColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeStateCallback() {
            self.isSelected = true
            self.controlDelegate.selectedIndex = index
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = Cons.control.highlightedColor
            } else if !isSelected {
                self.backgroundColor = Cons.control.buttonColor
            } else {
                self.backgroundColor = UIColor.green
            }
        }
    }
    
}






