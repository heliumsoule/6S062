//
//  Cons.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/14/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

struct Cons {
    
    struct screen {
    
        static let bounds = UIScreen.main.bounds
    }
    
    struct fieldname {
        
        static let color = UIColor.orange
        static let font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightThin)
        static let textAlignment:NSTextAlignment = .left
    }
    
    struct controls {
        
        static let names = [
            "Accuracy",
            "Record"
        ]
        
        static let accuracies = [
            "Cellular",
            "WiFi",
            "GPS"
        ]

        static let defaultColor = UIColor(red: CGFloat(33.0 / 255),
                                          green: CGFloat(174.0 / 255),
                                          blue: CGFloat(254.0 / 255),
                                          alpha: 1.0)
        static let highlightedColor = UIColor(red: CGFloat(29.0 / 255),
                                              green: CGFloat(155.0 / 255),
                                              blue: CGFloat(228.0 / 255),
                                              alpha: 1.0)
        static let tintColor = UIColor.white
        
    }

    
}
