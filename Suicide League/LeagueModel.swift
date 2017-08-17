//
//  TeamModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/3/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class LeagueModel {
    var name:String
    var lid:String
    var type:LeagueType
    init(name:String, type:LeagueType, lid:String) {
        self.name = name
        self.type = type
        self.lid = lid
    }
}
