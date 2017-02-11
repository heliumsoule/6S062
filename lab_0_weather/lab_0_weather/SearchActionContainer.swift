//
//  SearchActionContainer.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/11/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class SearchActionContainer: UIView {

    let searchButton = SearchActionButton()
    let searchField = SearchField()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
                
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
        self.addConstraint(QLayoutConstraint.horizontalSpacingConstraint(leftView: self.searchField, rightView: self.searchButton, spacing: 10))
    }

}
