//
//  PointsCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class PointsCell:UITableViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    func setCell(model: PointsModel) {
        if let rank = model.rank {
            self.rankLabel.text = "\(rank)"
        }
        self.nameLabel.text = model.name
        self.pointsLabel.text = model.score
    }
    
}
