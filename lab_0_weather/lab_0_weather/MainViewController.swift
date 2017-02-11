//
//  MainViewController.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/10/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let infoContainer = InfoContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        
        self.view.addSubview(self.infoContainer)
        
        customLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func customLayout() {
    
        self.view.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.infoContainer, sides: [.left, .right], padding: 0))
        self.view.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: self.infoContainer, side: .top, padding: 64))
        
//        self.view.addConstraints(QLayoutConstraint.fillYConstraints(view: self.infoContainer, heightRatio: 0.6))
        
    }

}

