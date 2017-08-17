//
//  LoginAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/6/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class LoginAPI {
    static let shared = LoginAPI()
    var UID = String()
    func login(username:String, password:String, completion: @escaping (String?) -> ()) {
        let url:URL = URL(string: prefix + "MobileLogin.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "username=\(username)&password=\(password)&remember_me=false"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion(nil); return}
            print(String.init(data: data, encoding: .utf8))
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    guard let UID = json["UID"] as? String else {completion(nil);return}
                    LoginAPI.shared.UID = UID
                    completion(UID)
                    return
                } else {
                    completion(nil)
                    return
                }
            } catch {
                completion(nil)
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func logout(completion:@escaping (Bool) -> ()) {
        let url:URL = URL(string: prefix + "MobileLogout.php")!
        let request:URLRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion(false); return}
            print("DONE" + String.init(data: data, encoding: .utf8)!)
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    guard let UID = json["response"] as? String else {completion(false);return}
                    LoginAPI.shared.UID = ""
                    completion(true)
                    return
                } else {
                    completion(false)
                    return
                }
            } catch {
                completion(false)
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    class func getLeagues(UID: String, completion: (String) -> ()) {
//        let url:URL = URL(string: prefix + "MobileTeams.php")!
//        let url:URL = URL(string: prefix + "MobileWeeks.php")!
        let url:URL = URL(string: prefix + "MobilePoints.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
//        let bodyData = "UID=\(UID)"
        let bodyData = "LID=299"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {return}
            
            let result = Serializer.serializeDataArray(data: data)
        })
        task.resume()
    }
}
