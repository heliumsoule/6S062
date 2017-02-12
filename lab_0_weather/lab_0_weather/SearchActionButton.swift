//
//  SearchActionButton.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/11/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class SearchActionButton: UIButton {
    
    enum State {
        case KeyboardDown
        case TextFieldEmpty
        case TextFieldFilled
    }
    
    let radius = Cons.searchButton.radius
    var currentState:State = .KeyboardDown
    
    init() {
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.changeSearchState(updatedState: .KeyboardDown)
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
    
    func changeSearchState(updatedState: State) {
        var currImage:UIImage
        var currInsets:UIEdgeInsets
        
        switch updatedState {
            
        case .KeyboardDown:
            currImage = Cons.searchButton.actionImg
            currInsets = Cons.searchButton.actionInsets
            
        case .TextFieldEmpty:
            currImage = Cons.searchButton.cancelImg
            currInsets = Cons.searchButton.cancelInsets
            
        case .TextFieldFilled:
            currImage = Cons.searchButton.filledImg
            currInsets = UIEdgeInsets.zero
//            currInsets = Cons.searchButton.cancelInsets
            
        }
        self.setImage(currImage, for: .normal)
        self.setImage(currImage, for: .highlighted)
        self.imageEdgeInsets = currInsets

        self.currentState = updatedState
    }
    
}










