//
//  MainViewController.swift
//  lab_0_weather
//
//  Created by Jing Lin on 2/10/17.
//  Copyright © 2017 6S062. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let searchContainer = SearchActionContainer()
    
    let infoContainer = InfoContainer()
    let imageLayer = CALayer()
    let darkOverlay = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "Snow_Background")!.scaleToSize(scaleSize: Cons.screen.bounds.size)
        self.imageLayer.frame = Cons.screen.bounds
        self.imageLayer.contents = backgroundImage.cgImage
        
        self.darkOverlay.frame = Cons.screen.bounds
        self.darkOverlay.backgroundColor = Cons.screen.overlayColor.cgColor
        
        self.view.layer.addSublayer(self.imageLayer)
        self.view.layer.addSublayer(self.darkOverlay)
    
        self.view.addSubview(self.infoContainer)
        self.view.addSubview(self.searchContainer)
        
        customLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func customLayout() {
    
        self.view.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.infoContainer, sides: [.left, .right], padding: 0))
        self.view.addConstraint(QLayoutConstraint.paddingPositionConstraint(view: self.infoContainer, side: .top, padding: 64))
        
        self.view.addConstraints(QLayoutConstraint.paddingPositionConstraints(view: self.searchContainer, sides: [.left, .bottom, .right], padding: 0))
        self.view.addConstraint(QLayoutConstraint.constantConstraint(view: self.searchContainer, attribute: .height, value: 59))
        
    }

}

