//
//  GeneralField.swift
//  
//
//  Created by Jing Lin on 2/10/17.
//
//

import UIKit

class GeneralField: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.text = text
        self.textColor = Cons.generalField.textColor
        self.font = UIFont.systemFont(ofSize: Cons.generalField.fontSize,
                                      weight: Cons.generalField.fontWeight)
        
        self.textAlignment = .center
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
