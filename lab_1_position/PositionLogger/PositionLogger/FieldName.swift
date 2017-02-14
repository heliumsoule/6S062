//
//  FieldName.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/14/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class FieldName: UILabel {
    
    init(name: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textColor = Cons.fieldname.color
        self.font = Cons.fieldname.font
        self.textAlignment = Cons.fieldname.textAlignment
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
