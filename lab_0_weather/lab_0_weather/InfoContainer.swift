//
//  InfoContainer.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/10/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class InfoContainer: UIView {

    let weatherFields = Cons.weather.fields.map { GeneralField(text: $0) }
    let anchorElement = UIView()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.anchorElement.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.anchorElement)
        weatherFields.forEach { self.addSubview($0) }
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        
        self.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.anchorElement, sides: [.left, .top, .right], padding: 0))
        self.addConstraint(QLayoutConstraint.constantConstraint(view: self.anchorElement, attribute: .height, value: 0))
        
        var topElement = self.anchorElement
        
        weatherFields.forEach {
            
            self.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: $0, sides: [.left, .right], padding: 0))
            self.addConstraint(QLayoutConstraint.verticalSpacingConstraint(upperView: topElement, lowerView: $0, spacing: 0))
            
            if $0 == weatherFields.last {
                self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: $0, side: .bottom, padding: 0))
            }
            
            topElement = $0
        }
    }
    
}
