//
//  BottomBorderLabel.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class BottomBorderLabel:UILabel {
    override func draw(_ rect: CGRect) {
        let bb = CALayer()
        let lg = UIColor(red: 0, green: 0.376470588, blue: 0, alpha: 1.0)
        bb.backgroundColor = lg.cgColor
        let bh:CGFloat = 1
        let lb = rect
        let lbh = lb.height
        let lbw = lb.width
        let bbF = CGRect(x: 0, y: lbh, width: lbw, height: bh)
        self.layer.addSublayer(bb)
        bb.frame = bbF
        super.draw(rect)
    }
}
