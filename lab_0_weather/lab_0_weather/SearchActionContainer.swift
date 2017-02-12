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
    let searchError = GeneralField(text: "Sorry, but the zipcode was invalid.")
    
    var weatherDelegate:WeatherInfoProtocol!
    
    init() {
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.clipsToBounds = false
        
        self.searchError.font = Cons.searchError.font
        self.searchError.textAlignment = .left
        
        toggleSearchError(displayError: false)
        
        self.searchField.addTarget(self, action: #selector(self.searchFieldChanged), for: .editingChanged)
        self.searchField.addTarget(self, action: #selector(self.searchFieldChanged), for: .editingDidBegin)
        
        self.searchButton.addTarget(self, action: #selector(self.changeEditing), for: .touchUpInside)
        
        self.addSubview(self.searchError)
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
        
        self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: self.searchError, side: .left, padding: 15))
        self.addConstraint(QLayoutConstraint.verticalSpacingConstraint(upperView: self.searchError, lowerView: self.searchField, spacing: 0))
        self.addConstraint(QLayoutConstraint.horizontalSpacingConstraint(leftView: self.searchError, rightView: self.searchButton, spacing: 15))
        
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
                        let locationJSON = weatherJSON["display_location"] as! [String: Any]
                        
                        let city = locationJSON["city"] as! String
                        let temperature = weatherJSON["temperature_string"] as! String
                        let description = weatherJSON["weather"] as! String
                        let humidity = weatherJSON["relative_humidity"] as! String
                        let wind = weatherJSON["wind_string"] as! String
                        let visibility = weatherJSON["visibility_km"] as! String
                        let visibilityKm = "\(visibility) km"
                        
                        self.weatherDelegate.updateWeatherInfo(city: city,
                                                               zipcode: zipcode,
                                                               temperature: temperature,
                                                               desc: description,
                                                               humidity: humidity,
                                                               wind: wind,
                                                               visibility: visibilityKm)
                        
                        self.toggleSearchError(displayError: false)
                        
                        self.searchField.text = ""
                        self.searchField.changeSearchState(isEditing: false)
                        
                        self.searchButton.changeSearchState(updatedState: .KeyboardDown)
                    } else {
                        
                        self.toggleSearchError(displayError: true)
                        
                    }
                    
                } else if let _ = response.error {
                    
                    self.toggleSearchError(displayError: true)
                    
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
    
    func toggleSearchError(displayError: Bool) {
        self.searchError.backgroundColor = displayError ? Cons.searchError.backgroundColor : Cons.color.clearColor
        self.searchError.textColor = displayError ? Cons.searchError.color : Cons.color.clearColor
        self.searchError.text = displayError ? Cons.searchError.errorMsg : ""
    }
    
}



