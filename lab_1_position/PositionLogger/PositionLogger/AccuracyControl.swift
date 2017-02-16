//
//  AccuracyControl.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/16/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class AccuracyControl: UIView {
    
    let controls:[FieldName]
    let controlsContainer = FieldContainer()
    
    let name = FieldName(name: "Accuracy")
    
    init() {
        self.controls = Cons.controls.accuracies.map { acc in FieldName(name: acc) }
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.controls.forEach { self.controlsContainer.addSubview($0) }
        self.addSubview(self.name)
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        self.addConstraint(QLayoutConstraint.verticalAlignConstraint(firstView: self.name, secondView: self))
        self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: self.name, side: .left, padding: 15))
        
        self.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: self.controlsContainer, side: .right, padding: 15))
        self.addConstraint(QLayoutConstraint.verticalAlignConstraint(firstView: self.controlsContainer, secondView: self))
    }
    
}
