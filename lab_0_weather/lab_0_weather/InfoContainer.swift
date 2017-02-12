//
//  InfoContainer.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/10/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class InfoContainer: UIView {

    let titleElement = GeneralField(text: "PLACEHOLDER")
    let weatherFields = Cons.weather.fields.map { (GeneralField(text: $0), GeneralField(text: $0)) }
    let anchorElement = UIView()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.anchorElement.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.anchorElement)
        weatherFields.forEach { (name, desc) in
            
            desc.textAlignment = .right
            desc.textColor = Cons.color.clearColor
            
            self.addSubview(name)
            self.addSubview(desc)
        }
        
        titleElement.textAlignment = .center
        titleElement.textColor = Cons.color.clearColor
        
        self.addSubview(self.titleElement)
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        
        self.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.anchorElement, sides: [.left, .top, .right], padding: 0))
        self.addConstraint(QLayoutConstraint.constantConstraint(view: self.anchorElement, attribute: .height, value: 0))
        
        self.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.titleElement, sides: [.left, .right], padding: 15))
        self.addConstraint(QLayoutConstraint.verticalSpacingConstraint(upperView: self.anchorElement, lowerView: self.titleElement, spacing: 0))
        
        var topElement = self.titleElement
        
        weatherFields.forEach { name, desc in
            
            let vSpacing:CGFloat = name == weatherFields[0].0 ? 44 : 10
            
            self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: name, side: .left, padding: 15))
            self.addConstraint(QLayoutConstraint.horizontalSpacingConstraint(leftView: name, rightView: desc, spacing: 40))
            self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: desc, side: .right, padding: 15))
            
            self.addConstraint(QLayoutConstraint.verticalSpacingConstraint(upperView: topElement, lowerView: name, spacing: vSpacing))
            self.addConstraint(QLayoutConstraint.verticalSpacingConstraint(upperView: topElement, lowerView: desc, spacing: vSpacing))
            
            
            if name == weatherFields.last!.0 {
                self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: name, side: .bottom, padding: 0))
            }
            
            topElement = desc
        }
    }
    
}

extension InfoContainer: WeatherInfoProtocol {
    
    func updateWeatherInfo(city: String, zipcode: String, temperature: String, desc: String, humidity: String, wind: String, visibility: String) {
        self.titleElement.text = "\(city) - \(zipcode)"
        
        self.weatherFields[0].1.text = temperature
        self.weatherFields[1].1.text = desc
        self.weatherFields[2].1.text = humidity
        self.weatherFields[3].1.text = wind
        self.weatherFields[4].1.text = visibility
        
        weatherFields.forEach { (_, desc) in
            
            desc.textColor = Cons.generalField.textColor
            
        }

        self.titleElement.textColor = Cons.generalField.textColor
        
    }
    
}









