//
//  Accuracy.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class Accuracy: UIView {
    
    let header = PositionLabel(text: Cons.accuracy.header)
    let segmentedControl = PositionControl(items: ["Cellular", "WiFi", "GPS"])
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
            
        self.addSubview(self.segmentedControl)
        self.addSubview(self.header)
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.header, sides: [.left, .right, .top, .bottom], padding: 0))
        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.segmentedControl, sides: [.left, .right], padding: 0))
        
        self.addConstraint(AutoLayoutConstraints.verticalSpacingConstraint(upperView: self.header, lowerView: self.segmentedControl, spacing: 15))
        self.addConstraint(AutoLayoutConstraints.constantConstraint(view: self.segmentedControl, attribute: .height, value: 40))
        self.addConstraint(AutoLayoutConstraints.paddingPositionConstraint(view: self.segmentedControl, side: .bottom, padding: 0))
    }
    
    func controlCallback() {
        
        print("Hello")
        
    }
    
}
