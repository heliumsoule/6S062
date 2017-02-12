//
//  SearchActionContainer.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/11/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import Alamofire
import UIKit

class SearchActionContainer: UIView {

    let searchButton = SearchActionButton()
    let searchField = SearchField()
    
    var weatherDelegate:WeatherInfoProtocol!
    
    init() {
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.searchField.addTarget(self, action: #selector(self.searchFieldChanged), for: .editingChanged)
        self.searchField.addTarget(self, action: #selector(self.searchFieldChanged), for: .editingDidBegin)
        
        self.searchButton.addTarget(self, action: #selector(self.changeEditing), for: .touchUpInside)
        
        self.addSubview(self.searchField)
        self.addSubview(self.searchButton)
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        
        self.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.searchButton, sides: [.right, .bottom], padding: 15))
        self.addConstraint(QLayoutConstraint.constantConstraint(view: self.searchButton, attribute: .height, value: Cons.searchButton.diameter))
        self.addConstraint(QLayoutConstraint.constantConstraint(view: self.searchButton, attribute: .width, value: Cons.searchButton.diameter))
        
        self.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.searchField, sides: [.left, .bottom], padding: 15))
        self.addConstraint(QLayoutConstraint.horizontalSpacingConstraint(leftView: self.searchField, rightView: self.searchButton, spacing: 15))
    }
    
}

extension SearchActionContainer {

    func changeEditing() {
        switch self.searchButton.currentState {
        case .KeyboardDown:
            self.searchField.changeSearchState(isEditing: true)
            self.searchButton.changeSearchState(updatedState: .TextFieldEmpty)
            
        case .TextFieldEmpty:
            self.searchField.changeSearchState(isEditing: false)
            self.searchButton.changeSearchState(updatedState: .KeyboardDown)
            
        case .TextFieldFilled:
            
            let zipcode = self.searchField.text!
                
            Alamofire.request(Router.ReadWeather(zipcode)).responseJSON { response in
                if let data = response.data {
                    
                    let dataJSON = String(data: data, encoding: .utf8)!.convertToDictionary()!
                    if let weatherJSON = dataJSON["current_observation"] as? [String: Any] {
                        
                        let temperature = weatherJSON["temperature_string"] as! String
                        let humidity = weatherJSON["relative_humidity"] as! String
                        let wind = weatherJSON["wind_string"] as! String
                        let visibility = weatherJSON["visibility_km"] as! String
                        
                        print("The fields found are \(temperature), \(humidity), \(wind), \(visibility)")
                        
                        
                        
                        self.searchField.text = ""
                        self.searchField.changeSearchState(isEditing: false)
                        self.searchButton.changeSearchState(updatedState: .KeyboardDown)
                    } else {
                        print("The city couldn't be found")
                    }
                    
                } else if let error = response.error {
                    print("The error was \(error)")
                }
            }
        }
    }
    
    func searchFieldChanged() {
        guard self.searchField.text != nil else {
            self.searchButton.changeSearchState(updatedState: .TextFieldEmpty)
            
            return
        }
        
        let currText = self.searchField.text!
        if currText.characters.count > 0 {
            self.searchButton.changeSearchState(updatedState: .TextFieldFilled)
        } else {
            self.searchButton.changeSearchState(updatedState: .TextFieldEmpty)
        }
    }
    
}



