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
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        weatherFields.forEach { self.addSubview($0) }
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        
        
        
    }
    
}
