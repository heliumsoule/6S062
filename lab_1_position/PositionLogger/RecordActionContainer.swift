//
//  Record.swift
//  PositionLogger
//
//  Created by Samuel Song on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class RecordActionContainer: UIView {
    
//    let header = PositionLabel(text: Cons.record.header)
    let recordButton = RecordActionButton()
    
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
//        self.backgroundColor = UIColor.magenta
        
//        self.addSubview(self.header)
        self.addSubview(self.recordButton)
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
//        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.header, sides: [.left, .right, .top], padding: 0))
        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.recordButton, sides: [.left, .right, .top], padding: 0))
        
//        self.addConstraint(AutoLayoutConstraints.verticalSpacingConstraint(upperView: self.header, lowerView: self.recordButton, spacing: 15))
        self.addConstraint(AutoLayoutConstraints.constantConstraint(view: self.recordButton, attribute: .height, value: 40))
        self.addConstraint(AutoLayoutConstraints.paddingPositionConstraint(view: self.recordButton, side: .bottom, padding: 0))
    }
    
}
