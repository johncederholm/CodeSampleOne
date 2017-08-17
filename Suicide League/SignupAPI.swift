//
//  SignupAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/14/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

enum SignupResponse:String {
    case success = "200"
    case nameTaken = "401"
    case invalidEmail = "402"
    case noPostData = "403"
    case other
}

class SignupAPI {
    class func signup(username:String, password:String, email:String, completion: @escaping (String?) -> ()) {
        let url:URL = URL(string: prefix + "MobileSignUp.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "username=\(username)&password=\(password)&email=\(email)"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion(nil); return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(json)
                    guard let response = json["response"] as? String else {completion(nil);return}
                    let r = SignupResponse(rawValue: response) ?? SignupResponse.other
                    switch r {
                    case .invalidEmail: completion("Invalid Email")
                    case .nameTaken: completion("Name Taken")
                    case .noPostData: completion("Try again")
                    case .other: completion("Try Again")
                    case .success: completion("Success")
                    }
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
}
