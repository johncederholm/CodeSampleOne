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
    init(name:String, id:String, isOut:Bool) {
        self.name = name
        self.id = id
        self.isOut = isOut
    }
}
