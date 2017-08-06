//
//  SideBordersLabel.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class SideBorderLabel:UILabel {
    override func draw(_ rect: CGRect) {
        let w:CGFloat = 1
        let leftLayer = CALayer()
        let lF = CGRect(x: 0, y: 0, width: w, height: rect.height)
        leftLayer.frame = lF
        leftLayer.backgroundColor = UIColor.darkGray.cgColor
        let rightLayer = CALayer()
        let rx = rect.width - w
        let rF = CGRect(x: rx, y: 0, width: w, height: rect.height)
        rightLayer.frame = rF
        rightLayer.backgroundColor = UIColor.darkGray.cgColor
        self.layer.addSublayer(leftLayer)
        self.layer.addSublayer(rightLayer)
        
        super.draw(rect)
    }
}
