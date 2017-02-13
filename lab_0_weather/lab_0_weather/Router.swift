//
//  Router.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/12/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://api.wunderground.com/api/\(WeatherUnderground.API)"

    case ReadWeather(String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .ReadWeather:
            return .get
        }
    }
    
    var path:String {
        switch self {
        case .ReadWeather(let zipcode):
            return "/conditions/q/\(zipcode).json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = NSURL(string: Router.baseURLString)!
        let urlRequest = URLRequest(url: url.appendingPathComponent(path)!)
        
        switch self {
        case .ReadWeather:
            return urlRequest
        }
    }
    
}
