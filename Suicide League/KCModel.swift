//
//  KCModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/14/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

let usernameDefault = "Username"
let passwordKeychain = "Password"

class KCModel {
    
    class func setInfo(username: String?, password: String?) {
        let keychain = KeychainSwift()
        if let username = username {
            _ = keychain.set(username, forKey: usernameDefault)
        }
        if let password = password {
            _ = keychain.set(password, forKey: passwordKeychain)
        }
    }
    
    class func deleteInfo(username: Bool, password: Bool) {
        let keychain = KeychainSwift()
        if username == true {_ = keychain.set("", forKey: usernameDefault)}
        if password == true {_ = keychain.set("", forKey: passwordKeychain)}
    }
    
    class func getInfo() -> (username: String?, password: String?) {
        let keychain = KeychainSwift()
        let username = keychain.get(usernameDefault)
        let password = keychain.get(passwordKeychain)
        return (username, password)
    }
}
