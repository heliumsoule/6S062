//
//  SearchActionButton.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/11/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class SearchActionButton: UIButton {
    
    let radius = Cons.searchButton.radius
    
    init() {
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setImage(UIImage(named: "Location_Icon")!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.setImage(UIImage(named: "Location_Icon")!.withRenderingMode(.alwaysTemplate), for: .highlighted)
        self.imageEdgeInsets = UIEdgeInsets(top: self.radius / 2,
                                            left: self.radius / 3,
                                            bottom: self.radius / 4,
                                            right: self.radius / 2)
        
        self.tintColor = Cons.searchButton.tintColor
        
        self.layer.cornerRadius = radius
        self.backgroundColor = Cons.searchButton.color
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = Cons.searchButton.highlightedColor
            } else {
                self.backgroundColor = Cons.searchButton.color
            }
        }
        
    }
    
}
