//
//  PositionControl.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class PositionControl: UIView, PositionControlDelegate {
    
    let leftElement = UIView()
    
    let actions:[PositionButton]
    
    var selectedIndex: Int = 0 {
        didSet {
            for (index, action) in self.actions.enumerated() {
//                action.backgroundColor = index == selectedIndex ? UIColor.green : Cons.control.buttonColor
                action.isHighlighted = index == selectedIndex ? true : false
            }
        }
        
    }
    
    init(items: [String]) {
        self.actions = items.enumerated().map { (index, title) in PositionButton(title: title, index: index) }
        defer {
            self.selectedIndex = 1
        }
        
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftElement.translatesAutoresizingMaskIntoConstraints = false

        self.actions.forEach { $0.controlDelegate = self }
        
        self.layer.cornerRadius = 2.0
        self.clipsToBounds = true
        
        self.actions.forEach { self.addSubview($0) }
        
        self.addSubview(leftElement)
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        var left = leftElement
        let nActions = self.actions.count
        
        let lastElement = nActions - 1
        let widthRatio = 1.0 / CGFloat(nActions)
        
        for (index, action) in self.actions.enumerated() {
            
            self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: action, sides: [.top, .bottom], padding: 0))
            self.addConstraint(AutoLayoutConstraints.horizontalSpacingConstraint(leftView: left, rightView: action, spacing: 0))
            
            self.addConstraint(NSLayoutConstraint(item: action, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: widthRatio, constant: 0))
            if index == lastElement {
                self.addConstraint(AutoLayoutConstraints.paddingPositionConstraint(view: action, side: .right, padding: 0))
            }
            left = action
        }
    }
}
