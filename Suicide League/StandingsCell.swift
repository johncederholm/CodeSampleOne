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
        leftLabel.text = model.inTeamName
        rightLabel.text = model.outTeamName
    }
}
