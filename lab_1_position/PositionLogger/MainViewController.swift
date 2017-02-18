//
//  MainViewController.swift
//  PositionLogger
//
//  Created by Jing Lin on 2/18/17.
//  Copyright © 2017 6.S062. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let accuracy = Accuracy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.accuracy)
        
        customLayout()
    }
    
    func customLayout() {
        self.view.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.accuracy, sides: [.left, .right], padding: 15))
        self.view.addConstraint(AutoLayoutConstraints.paddingPositionConstraint(view: self.accuracy, side: .top, padding: 64))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
