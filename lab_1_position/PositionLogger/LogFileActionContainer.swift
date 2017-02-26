//
//  LogFileActionContainer.swift
//  PositionLogger
//
//  Created by Samuel Song on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class LogFileActionContainer: UIView {
    
    let emailButton = LogFileEmailButton()
    let clearButton = LogFileClearButton()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //        self.backgroundColor = UIColor.magenta
        
        //        self.addSubview(self.header)
        
//        self.backgroundColor = UIColor.green
        
        self.addSubview(emailButton)
        self.addSubview(clearButton)
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        self.addConstraint(AutoLayoutConstraints.horizontalAlignConstraint(firstView: self.emailButton, secondView: self.clearButton))
        self.addConstraint(AutoLayoutConstraints.horizontalSpacingConstraint(leftView: self.emailButton, rightView: self.clearButton, spacing: 10))
        
        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.emailButton, sides: [.left, .top, .bottom], padding: 0))
        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.clearButton, sides: [.right, .top, .bottom], padding: 0))
        
        self.addConstraint(AutoLayoutConstraints.equalConstraint(firstView: self.emailButton, secondView: self.clearButton, attribute: .width))
    }
    
}
