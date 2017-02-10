//
//  Cons.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/10/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

struct Cons {
    
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
        
        static let textColor = UIColor.cyan
        
        static let fontSize:CGFloat = 16.0
        static let fontWeight = UIFontWeightRegular
    }
    
}
