//
//  WeatherInfoProtocol.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/12/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

protocol WeatherInfoProtocol {
    
    func updateWeatherInfo(city: String, zipcode: String, temperature: String, humidity: String, wind: String, visibility: String)
    
}
