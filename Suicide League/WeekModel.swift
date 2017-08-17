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
    var leftTeamName:String
    var leftTeamColors:[UIColor]
    var leftN:String
    var date:String
    var time:String
    var rightTeamName:String
    var rightTeamColors:[UIColor]
    var rightN:String
    
    init(ltn:String,lc:[UIColor],d:String,t:String,rtn:String,rc:[UIColor],ln:String,rn:String) {
        self.leftTeamName = ltn
        self.leftTeamColors = lc
        self.date = d
        self.time = t
        self.rightTeamName = rtn
        self.rightTeamColors = rc
        self.leftN = ln
        self.rightN = rn
    }
}
