//
//  Router.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/12/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "
    
    
}

//enum Router: URLRequestConvertible {
//    static let baseURLString = "http://ec2-54-87-129-225.compute-1.amazonaws.com/api"
//    static var authorizationToken:String?
//    
//    case create_user([String: AnyObject])
//    case update_user_location([String: AnyObject])
//    
//    var method: Alamofire.Method {
//        switch self {
//        case .create_user:
//            return .post
//        case .update_user_location:
//            return .post
//        }
//    }
//    
//    var path: String {
//        switch self {
//        case .create_user:
//            return "user/create_user"
//        case .update_user_location:
//            return "user/update_user_location"
//        }
//    }
//    
//    var URLRequest: NSMutableURLRequest {
//        
//        let URL = NSURL(string: Router.baseURLString)
//        let mutableURLRequest = path != "" ?
//            NSMutableURLRequest(URL: (URL!.URLByAppendingPathComponent(path))) : NSMutableURLRequest(URL: URL!)
//        mutableURLRequest.HTTPMethod = method.rawValue
//        
//        if let token = Router.authorizationToken {
//            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
//        
//        switch self {
//        case .create_user(let parameters):
//            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
//        case .update_user_location(let parameters):
//            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
//        }
//        
//    }
//    
//}
