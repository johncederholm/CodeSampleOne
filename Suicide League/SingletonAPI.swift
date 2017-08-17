//
//  SingletonAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/7/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class SingletonAPI {
    static let sharedInstance = SingletonAPI()
    
    var showLeagues = String()
    var userID = String()
}
