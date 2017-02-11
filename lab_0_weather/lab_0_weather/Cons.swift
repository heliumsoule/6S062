//
//  Cons.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/10/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

struct Cons {
    
    struct screen {
        static let bounds = UIScreen.main.bounds
        
        static let overlayColor = UIColor.black.withAlphaComponent(0.25)
    }
    
    struct weather {
        static let fields = [
            "Temperature",
            "Description",
            "Humidity",
            "Wind",
            "Visibility"
        ]
    }
    
    struct generalField {
        
        static let textColor = UIColor.white
        
        static let fontSize:CGFloat = 18.0
        static let fontWeight = UIFontWeightLight
    }
    
}
