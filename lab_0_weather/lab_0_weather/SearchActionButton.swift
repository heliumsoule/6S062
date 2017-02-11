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
        
        self.changeSearchState(isEditing: false)
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
    
    func changeSearchState(isEditing: Bool) {
        let currImage = isEditing ? Cons.searchButton.cancelImg : Cons.searchButton.actionImg
        let currInsets = isEditing ? Cons.searchButton.cancelInsets: Cons.searchButton.actionInsets
        
        self.setImage(currImage, for: .normal)
        self.setImage(currImage, for: .highlighted)
        self.imageEdgeInsets = currInsets

    }
    
}










