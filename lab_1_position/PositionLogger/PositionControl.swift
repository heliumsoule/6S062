//
//  PositionControl.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class PositionControl: UIScrollView {
    
    let states:[PositionLabel]
    let highlighter = UIView()
    
    var highlighterConstraint:NSLayoutConstraint!
    
    init(items: [String]) {
        self.states = items.map { PositionLabel(text: $0) }
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.highlighter.translatesAutoresizingMaskIntoConstraints = false
        
        self.highlighter.backgroundColor = UIColor.yellow
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.highlighter.backgroundColor = Cons.control.highlightedColor
        self.backgroundColor = Cons.control.buttonColor
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PositionControl.changeControl)))
        
        self.addSubview(self.highlighter)
        self.states.forEach {
            $0.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightThin)
            self.addSubview($0)
        }
        
        customLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customLayout() {
        let centerRatio = 2.0 / CGFloat(self.states.count)
        let widthRatio = 1.0 / CGFloat(self.states.count)

        self.highlighterConstraint = NSLayoutConstraint(item: self.highlighter, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 0.5 * centerRatio, constant: 0)
        self.addConstraint(self.highlighterConstraint)
        self.addConstraint(AutoLayoutConstraints.constantConstraint(view: self.highlighter, attribute: .height, value: 36.0))
        self.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.highlighter, sides: [.top, .bottom], padding: 0))
        self.addConstraint(AutoLayoutConstraints.fillXConstraints(view: self.highlighter, widthRatio: widthRatio))
        
        for (index, action) in self.states.enumerated() {
            let centerX = (CGFloat(index) + 0.5) * centerRatio
            
            self.addConstraint(AutoLayoutConstraints.verticalAlignConstraint(firstView: action, secondView: self))
            self.addConstraint(AutoLayoutConstraints.fillXConstraints(view: action, widthRatio: widthRatio))
            self.addConstraint(NSLayoutConstraint(item: action, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: centerX, constant: 0))
        }
    }
    
    func changeControl(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self)
        let centerRatio = 2.0 / CGFloat(self.states.count)
        let index = floor(touchPoint.x / (self.bounds.width / CGFloat(self.states.count)))
        
        self.removeConstraint(self.highlighterConstraint)
        self.highlighterConstraint = NSLayoutConstraint(item: self.highlighter, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: (CGFloat(index) + 0.5) * centerRatio, constant: 0)
        self.addConstraint(self.highlighterConstraint)
        
    }
    
}






