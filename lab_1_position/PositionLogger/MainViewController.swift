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
    let record = RecordActionContainer()
    let logFileActions = LogFileActionContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        self.view.addSubview(self.accuracy)
        
        self.view.addSubview(self.record)
        
        self.view.addSubview(self.logFileActions)
        
        customLayout()
    }
    
    func customLayout() {
        self.view.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.accuracy, sides: [.left, .right], padding: 15))
        self.view.addConstraint(AutoLayoutConstraints.paddingPositionConstraint(view: self.accuracy, side: .top, padding: 64))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addConstraint(AutoLayoutConstraints.verticalSpacingConstraint(upperView: self.accuracy, lowerView: self.record, spacing: 20))
        self.view.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.record, sides: [.left, .right], padding: 15))
        
//        self.view.addConstraint(AutoLayoutConstraints.verticalSpacingConstraint(upperView: <#T##UIView#>, lowerView: <#T##UIView#>, spacing: <#T##CGFloat#>))
        self.view.addConstraints(AutoLayoutConstraints.paddingPositionConstraints(view: self.logFileActions, sides: [.left, .right], padding: 15))
        self.view.addConstraint(AutoLayoutConstraints.paddingPositionConstraint(view: self.logFileActions, side: .bottom, padding: 30))
        self.view.addConstraint(AutoLayoutConstraints.constantConstraint(view: self.logFileActions, attribute: .height, value: 40))
    }
    
}
