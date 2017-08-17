//
//  WeekSelectionCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class WeekSelectionCell: UITableViewCell {
    var weekLabel:UILabel!
    override func draw(_ rect: CGRect) {
        weekLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width, height: rect.height))
        self.addSubview(weekLabel)
    }
    
    func setCell(name:String) {
        if let weekLabel = weekLabel {
            weekLabel.text = name
        }
    }
}
