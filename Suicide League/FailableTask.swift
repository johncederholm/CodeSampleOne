//
//  FailableTask.swift
//  Suicide League
//
//  Created by John Cederholm on 9/1/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class FailableTask {
    class func run(u:URL, mt: String, b:String, r:Int, s: URLSession, suc: @escaping (Data) -> (), fa: @escaping (Error) -> ()) {
        var req:URLRequest = URLRequest(url: u)
        req.httpMethod = mt
        req.httpBody = b.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
            if let data = data {
                if String.init(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true{
                    if r > 0 {
                        FailableTask.run(u: u, mt: mt, b: b, r: r - 1, s: s, suc: suc, fa: fa)
                    } else {
                        let errorF = NSError(domain: "", code: 400, userInfo: nil)
                        fa(errorF)
                    }
                    return
                }
                suc(data)
                return
            } else {
                if r > 0 {
                    FailableTask.run(u: u, mt: mt, b: b, r: r - 1, s: s, suc: suc, fa: fa)
                    return
                } else {
                    let errorF = NSError(domain: "", code: 400, userInfo: nil)
                    fa(errorF)
                    return
                }
            }
            
        })
        task.resume()
    }
}
