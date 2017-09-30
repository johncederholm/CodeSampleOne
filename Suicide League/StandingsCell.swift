//
//  StandingsCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/14/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class StandingsCell:UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    func setCell(model:StandingsModel) {
        leftLabel.text = model.inTeamName.0
        if model.inTeamName.1 == true {
            leftLabel.font = UIFont(name: textFontBold, size: 15)
            leftLabel.textColor = UIColor.white
        } else {
            leftLabel.font = UIFont(name: textFont, size: 15)
            leftLabel.textColor = UIColor.lightGray
        }
        rightLabel.text = model.outTeamName.0
        if model.outTeamName.1 == true {
            rightLabel.font = UIFont(name: textFontBold, size: 15)
        } else {
            rightLabel.font = UIFont(name: textFont, size: 15)
        }
    }
}
