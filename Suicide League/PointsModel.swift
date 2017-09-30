//
//  PointsModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class PointsModel {
    var name:String
    var score:String
    var rank:Int?
    var isSelf:Bool
    init(name:String, score:String, isSelf:Bool) {
        self.name = name
        self.score = score
        self.isSelf = isSelf
    }
}
