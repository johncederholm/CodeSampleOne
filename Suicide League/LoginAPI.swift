//
//  LoginAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/6/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

enum LoginResponse:String {
    case success = "200"
    case email = "300"
    case noResponse = "301"
    case needsDisclaimer = "302"
    case noUsername = "405"
    case noPassword = "406"
}

class LoginAPI {
    static let shared = LoginAPI()
    var UID = String()
    func login(username:String, password:String, isDisclaimer:Bool, completion: @escaping (String?, LoginResponse?) -> ()) {
        let url:URL = URL(string: prefix + "MobileLogin.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        var bodyData = "username=\(username)&password=\(password)&remember_me=false"
        if isDisclaimer == true {
            bodyData.append("&disclaimer=0")
        }
        request.httpBody = bodyData.data(using: .utf8)
        
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    var message:String? = nil
                    guard let resp = json["response"] as? String else {completion(nil, nil);return}
                    guard let loginResponse = LoginResponse(rawValue: resp) else {completion(nil,nil);return}
                    if let UID = json["UID"] as? String {
                        LoginAPI.shared.UID = UID
                        message = UID
                    }
                    if let disclaimer = json["disclaimer"] as? String {
                        message = disclaimer
                    }
                    
                    if loginResponse == LoginResponse.success {
                        UserDefaults.standard.set("0", forKey: UserDefKeys.disclaimer.rawValue)
                    } else {
                        UserDefaults.standard.set("1", forKey: UserDefKeys.disclaimer.rawValue)
                    }
                    if loginResponse == LoginResponse.email {
                        message = "Check your email and click the verification link."
                    }
                    completion(message, loginResponse)
                    return
                } else {
                    completion(nil, nil)
                    return
                }
            } catch {
                completion(nil, nil)
            }
        }, fa: {error in
            completion(nil, nil)
            return
        })
    }
    
    func logout(completion:@escaping (Bool) -> ()) {
        let url:URL = URL(string: prefix + "MobileLogout.php")!
        FailableTask.run(u: url, mt: "POST", b: "", r: 3, s: URLSession.shared, suc: {data in
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if json["response"] as? String == nil {completion(false);return}
                    LoginAPI.shared.UID = ""
                    completion(true)
                    return
                } else {
                    completion(false)
                    return
                }
            } catch {
                completion(false)
            }
        }, fa: {failure in
            completion(false)
            return
        })
    }
}
