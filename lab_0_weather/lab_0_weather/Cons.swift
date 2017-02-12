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
    
    struct color {
        
        static let clearColor = UIColor.clear
    }
    
    struct searchButton {
        
        static let radius:CGFloat = 22.0
        static let diameter:CGFloat = 44.0
        
        static let color = UIColor(red: CGFloat(33.0 / 255),
                                   green: CGFloat(174.0 / 255),
                                   blue: CGFloat(254.0 / 255),
                                   alpha: 1.0)
        
        static let highlightedColor = UIColor(red: CGFloat(29.0 / 255),
                                              green: CGFloat(155.0 / 255),
                                              blue: CGFloat(228.0 / 255),
                                              alpha: 1.0)
        
        static let actionImg = UIImage(named: "Location_Icon")!.withRenderingMode(.alwaysTemplate)
        static let cancelImg = UIImage(named: "Cross")!.withRenderingMode(.alwaysTemplate)
        static let filledImg = UIImage(named: "Check")!.withRenderingMode(.alwaysTemplate)
        
        static let actionInsets = UIEdgeInsets(top: radius / 2,
                                               left: radius / 3,
                                               bottom: radius / 4,
                                               right: radius / 2)
        static let cancelInsets = UIEdgeInsets(top: radius / 2,
                                               left: radius / 2,
                                               bottom: radius / 2,
                                               right: radius / 2)

        
        static let tintColor = UIColor.white
        
    }
    
    struct searchField {
        
        static let placeholder = "Enter zip code here."
        
        static let fontSize:CGFloat = 18.0
        
        static let padding = UIEdgeInsets(top: 7, left: 5, bottom: 7, right: 0)
        
        static let color = UIColor.white
        
        static let borderWidth:CGFloat = 2.0
        static let borderColor = UIColor.white
        static let backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
    }
    
    struct searchError {
        
        static let font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
        
        static let backgroundColor = UIColor.red.withAlphaComponent(0.3)
        
        static let color = UIColor.white
        
        static let errorMsg = "Sorry, but the zipcode doesn't exist."
        
    }
    
    struct weather {
        static let fields = [
            "Temperature",
//            "Description",
            "Humidity",
            "Wind",
            "Visibility"
        ]
    }
    
    struct generalField {
        
        static let textColor = UIColor.white
        
        static let fontSize:CGFloat = 20.0
        static let fontWeight = UIFontWeightLight
    }
    
}
