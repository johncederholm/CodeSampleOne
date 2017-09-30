//
//  TeamModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/7/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class TeamModel {
    let name:String
    let id:String
    let isOut:Bool
    let isPicked:Bool
    let teamName:String?
    let currentWeek:String
    init(name:String, id:String, isOut:Bool, isPicked:Bool, currentWeek:String, teamName:String?) {
        self.name = name
        self.id = id
        self.isOut = isOut
        self.isPicked = isPicked
        self.currentWeek = currentWeek
        if let teamName = teamName {
            self.teamName = NFLModel.getTeam(teamNumber: teamName).name
        } else {
            self.teamName = teamName
        }
    }
}
