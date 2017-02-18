//
//  Cons.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

struct Cons {
    
    struct screen {
        static let dims = UIScreen.main.bounds
    }
    
    struct positionLabel {
        static let font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightThin)
        static let textColor = UIColor.black.withAlphaComponent(0.7)
        static let nLines = 1
    }
    
    struct accuracy {
        static let header = "Choose an accuracy"
    }
    
    struct control {
        static let color = UIColor(red: CGFloat(96.0 / 255),
                                   green: CGFloat(200.0 / 255),
                                   blue: CGFloat(248.0 / 255),
                                   alpha: 1.0)
        static let buttonColor = UIColor(red: CGFloat(255.0 / 255),
                                         green: CGFloat(163.0 / 255),
                                         blue: CGFloat(0.0 / 255),
                                         alpha: 1.0)
        
        static let highlightedColor = UIColor(red: CGFloat(230.0 / 255),
                                              green: CGFloat(145.0 / 255),
                                              blue: CGFloat(0.0 / 255),
                                              alpha: 1.0)
    }
    
}
