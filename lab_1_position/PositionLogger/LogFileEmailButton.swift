//
//  LogFileEmailButton.swift
//  PositionLogger
//
//  Created by Samuel Song on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class LogFileEmailButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = Cons.recordButton.backgroundColor
        self.setTitleColor(Cons.recordButton.textColor, for: .normal)
        self.setTitle("Email", for: .normal)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
