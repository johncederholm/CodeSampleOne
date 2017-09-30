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
    class func signup(username:String, password:String, email:String, completion: @escaping (SignupResponse?, String?) -> ()) {
        let url:URL = URL(string: prefix + "MobileSignup.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "username=\(username)&password=\(password)&email=\(email)"
        request.httpBody = bodyData.data(using: .utf8)
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    guard let response = json["response"] as? String else {completion(nil, nil);return}
                    let r = SignupResponse(rawValue: response) ?? SignupResponse.other
                    var mess:String?
                    switch r {
                    case .invalidEmail: mess = "Invalid Email"
                    case .nameTaken: mess = "Name Taken"
                    case .noPostData: mess = "Try again"
                    case .other: mess = "Try Again"
                    case .success: mess = "Success"
                    }
                    completion(r, mess)
                    return
                } else {
                    completion(nil, nil)
                    return
                }
            } catch {
                completion(nil, nil)
            }
        }, fa: {failure in
            completion(nil, nil)
        })
    }
}
