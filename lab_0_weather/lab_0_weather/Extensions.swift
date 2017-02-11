//
//  Extensions.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/11/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

extension UIImage {
    
    func scaleToSize(scaleSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(scaleSize, true, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: scaleSize.width, height: scaleSize.height))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
}
