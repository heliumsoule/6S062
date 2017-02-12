//
//  SearchField.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/11/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class SearchField: UITextField {
    
    let borderWidth = Cons.searchField.borderWidth
    
    let padding = Cons.searchField.padding
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.tintColor = Cons.searchField.color
        
        self.font = UIFont.systemFont(ofSize: Cons.searchField.fontSize)
        self.attributedPlaceholder = NSAttributedString(string: Cons.searchField.placeholder,
                                                        attributes: [NSForegroundColorAttributeName: Cons.searchField.color,
                                                                     NSFontAttributeName: UIFont.systemFont(ofSize: Cons.searchField.fontSize)])
        
        
        self.keyboardType = .numberPad
        self.contentVerticalAlignment = .center
        
        self.textColor = Cons.searchField.color
        self.backgroundColor = Cons.searchField.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let bounds = self.bounds
        
        let bezierPath = UIBezierPath()

        let startPoint = CGPoint(x: 0, y: bounds.height - self.borderWidth / 2)
        let endPoint = CGPoint(x: bounds.width, y: bounds.height - self.borderWidth / 2)
        
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)

        Cons.searchField.borderColor.setStroke()
        
        bezierPath.lineWidth = self.borderWidth
        bezierPath.stroke()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, self.padding))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: UIEdgeInsetsInsetRect(bounds, self.padding))
    }
    
    func changeSearchState(isEditing: Bool) {
        let _ = isEditing ? self.becomeFirstResponder() : self.resignFirstResponder()
    }
    
}











