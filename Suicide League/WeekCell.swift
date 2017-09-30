//
//  WeekCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/4/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

enum WeekSide {
    case left
    case right
}

protocol WeekCellDelegate:class {
    func didSelect(button cell:WeekCell, team:String)
}

class WeekCell:UITableViewCell {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftTopColor: UIView!
    @IBOutlet weak var leftBottomColor: UIView!
    @IBOutlet weak var leftTeamLabel: UILabel!
    @IBOutlet weak var dateLabel: SideBorderLabel!
    @IBOutlet weak var rightTopColor: UIView!
    @IBOutlet weak var rightBottomColor: UIView!
    @IBOutlet weak var rightTeamLabel: UILabel!
    
    var delegate:WeekCellDelegate?
    var week:WeekModel?
    func setCell(model:WeekModel, pick:PickModel?) {
        self.week = model
        leftTopColor.backgroundColor = model.leftTeamColors.first
        leftBottomColor.backgroundColor = model.leftTeamColors.last
        leftTeamLabel.text = model.leftTeamName
        dateLabel.text = "@" + "\n" + model.date + "\n" + model.time + " est"
        rightTopColor.backgroundColor = model.rightTeamColors.first
        rightBottomColor.backgroundColor = model.rightTeamColors.last
        rightTeamLabel.text = model.rightTeamName
        leftButton.addTarget(self, action: #selector(WeekCell.leftSelect(sender:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(WeekCell.rightSelect(sender:)), for: .touchUpInside)
        leftTeamLabel.backgroundColor = UIColor.clear
        rightTeamLabel.backgroundColor = UIColor.clear
        if let pick = pick {
            if pick.teamNumber == model.leftN {
                leftTeamLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "#296609")
            } else if pick.teamNumber == model.rightN {
                rightTeamLabel.backgroundColor = UIColor.hexStringToUIColor(hex: "#296609")
            }
        }
    }
    
    func leftSelect(sender:AnyObject) {
        guard let team = week?.leftN else {return}
        delegate?.didSelect(button: self, team: team)
    }
    
    func rightSelect(sender:AnyObject) {
        guard let team = week?.rightN else {return}
        delegate?.didSelect(button: self, team: team)
    }
}
