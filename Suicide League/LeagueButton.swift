//
//  LeagueButton.swift
//  Suicide League
//
//  Created by John Cederholm on 8/3/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

enum LeagueType:String {
    case privateClassicLeague = "privateClassic"
    case privatePointsLeague = "privatePoints"
    case publicClassicLeague = "publicClassic"
    case publicPointsLeague = "publicPoints"
}

class LeagueButton:UIButton {
    @IBInspectable
    var leagueButtonType:String! {
        didSet {
            leagueType = LeagueType(rawValue: leagueButtonType)
        }
    }
    var leagueType:LeagueType!
}
