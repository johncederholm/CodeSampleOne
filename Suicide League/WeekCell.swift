//
//  WeekCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/4/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class WeekCell:UITableViewCell {
    @IBOutlet weak var leftTopColor: UIView!
    @IBOutlet weak var leftBottomColor: UIView!
    @IBOutlet weak var leftCityLabel: UILabel!
    @IBOutlet weak var leftNameLabel: UILabel!
    @IBOutlet weak var dateLabel: SideBorderLabel!
    @IBOutlet weak var rightTopColor: UIView!
    @IBOutlet weak var rightBottomColor: UIView!
    @IBOutlet weak var rightCityLabel: UILabel!
    @IBOutlet weak var rightNameLabel: UILabel!
    
    func setCell(model:WeekModel) {
        leftTopColor.backgroundColor = model.leftTeamColors.first
        leftBottomColor.backgroundColor = model.leftTeamColors.last
        leftCityLabel.text = model.leftTeamCity
        leftNameLabel.text = model.leftTeamName
        dateLabel.text = "@" + model.date + "\n" + model.time
        rightTopColor.backgroundColor = model.rightTeamColors.first
        rightBottomColor.backgroundColor = model.rightTeamColors.last
        rightCityLabel.text = model.rightTeamCity
        rightNameLabel.text = model.rightTeamName
    }
}
