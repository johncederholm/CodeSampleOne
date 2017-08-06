//
//  WeekModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/4/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class WeekModel {
    var leftTeamCity:String
    var leftTeamName:String
    var leftTeamColors:[UIColor]
    var date:String
    var time:String
    var rightTeamCity:String
    var rightTeamName:String
    var rightTeamColors:[UIColor]
    
    init(ltc:String,ltn:String,lc:[UIColor],d:String,t:String,rtc:String,rtn:String,rc:[UIColor]) {
        self.leftTeamCity = ltc
        self.leftTeamName = ltn
        self.leftTeamColors = lc
        self.date = d
        self.time = t
        self.rightTeamCity = rtc
        self.rightTeamName = rtn
        self.rightTeamColors = rc
    }
}
