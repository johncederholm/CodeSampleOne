//
//  TeamCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/3/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class TeamCell:UITableViewCell {
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var pickLabel: UILabel!
    
    func setCell(model:TeamModel) {
        self.teamLabel.text = model.name
        if model.isPicked {
            let tm = model.teamName ?? ""
            self.pickLabel.text = "Change pick" + " - " + tm
        } else {
            self.pickLabel.text = "Make a pick"
        }
        if model.isOut {
            self.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            self.typeImage.image = UIImage(named: "out")
        } else {
            self.backgroundColor = UIColor(red: 0, green: 0.196078, blue: 0, alpha: 1.0)
            self.typeImage.image = UIImage(named: "football")
        }
    }
}
