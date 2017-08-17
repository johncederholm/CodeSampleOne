//
//  LeagueCell.swift
//  Suicide League
//
//  Created by John Cederholm on 8/7/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class LeagueCell:UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ballImage: UIImageView!
    
    func setCell(league:LeagueModel) {
        name.text = league.name
        var imageName:String!
        switch league.type {
        case .publicPointsLeague:
            imageName = "public"
        case .publicClassicLeague:
            imageName = "public"
        case .privatePointsLeague:
            imageName = "private"
        case .privateClassicLeague:
            imageName = "private"
        }
        ballImage.image = UIImage(named: imageName)
    }
}
