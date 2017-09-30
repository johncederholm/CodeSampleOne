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
    var inTeamName:(String?, Bool?)
    var outTeamName:(String?, Bool?)
    init(inTeamName:(String?, Bool?), outTeamName:(String?, Bool?)) {
        self.inTeamName = inTeamName
        self.outTeamName = outTeamName
    }
}
