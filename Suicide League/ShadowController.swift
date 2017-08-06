//
//  ShadowController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class ShadowController:UIViewController {
    var shadowView:UIView!
    var shadowSize:CGFloat {
        get {
            return self.view.bounds.width / 5
        }
    }
    var shadowCenter:CGPoint {
        get {
            return self.view.center
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applyShadows()
    }
    
    func applyShadows() {
        if (shadowView != nil) {return}
        shadowView = UIView()
        shadowView.frame.size = CGSize(width: shadowSize, height: shadowSize)
        shadowView.center = shadowCenter
        self.view.addSubview(shadowView)
        self.view.sendSubview(toBack: shadowView)
        applyShadow(shadowView: shadowView)
    }
    
    func applyShadow(shadowView: UIView) {
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.white.cgColor
        shadowView.layer.shadowRadius = 50
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize.zero
        let x = shadowView.bounds.origin.x
        let y = shadowView.bounds.origin.y
        let width = shadowView.bounds.width
        let height = shadowView.bounds.height
        shadowView.layer.shadowPath = CGPath(rect: CGRect(x: x, y: y, width: width, height: height), transform: nil)
    }
}
