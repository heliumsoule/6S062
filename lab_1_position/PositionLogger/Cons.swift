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
        static let textColor = UIColor.black
        static let nLines = 1
    }
    
    struct accuracy {
        static let header = "Choose an accuracy"
    }
    
    struct record {
        
        static let header = "Begin recording"
        
    }
    
    struct recordButton {
        
        static let textColor = UIColor(red: CGFloat(0x33/255.0),
                                       green: 0,
                                       blue: CGFloat(0x99/255.0),
                                       alpha: 1.0)
        
        static let backgroundColor = UIColor(red: CGFloat(52.0 / 255),
                                             green: CGFloat(152.0 / 255),
                                             blue: CGFloat(219.0 / 255),
                                             alpha: 1.0)
        
        static let pressedColor = UIColor(red: CGFloat(41.0 / 255),
                                          green: CGFloat(128.0 / 255),
                                          blue: CGFloat(185.0 / 255),
                                          alpha: 1.0)
        
    }
    
    struct control {
        static let color = UIColor(red: CGFloat(96.0 / 255),
                                   green: CGFloat(200.0 / 255),
                                   blue: CGFloat(248.0 / 255),
                                   alpha: 1.0)
        static let buttonColor = UIColor(red: CGFloat(0.0 / 255),
                                         green: CGFloat(204.0 / 255),
                                         blue: CGFloat(255.0 / 255),
                                         alpha: 1.0)
        static let highlightedColor = UIColor(red: CGFloat(66.0 / 255),
                                              green: CGFloat(180.0 / 255),
                                              blue: CGFloat(230.0 / 255),
                                              alpha: 1.0)
    }
    
}
