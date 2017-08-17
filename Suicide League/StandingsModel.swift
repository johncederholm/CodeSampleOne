//
//  StandingsModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/14/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class StandingsModel {
    var inTeamName:String?
    var outTeamName:String?
    
    init(inTeamName:String?, outTeamName:String?) {
        self.inTeamName = inTeamName
        self.outTeamName = outTeamName
    }
}
