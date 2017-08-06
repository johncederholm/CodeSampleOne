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
    case privateLeague = "private"
    case publicLeague = "public"
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
