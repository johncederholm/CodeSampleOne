//
//  PickAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/12/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class PickAPI {
    class func makePick(uid:String, lid:String, tid:String, pick:String, pickweek:String, completion: @escaping (Bool) -> ()) {
        let url:URL = URL(string: prefix + "MobileMakePicks.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "ShowUID=\(uid)&ShowLID=\(lid)&ShowTID=\(tid)&Pick=\(pick)&PickWeek=\(pickweek)"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion(false);return}
            let str = String.init(data: data, encoding: .utf8)
            guard let results = Serializer.serializeDataArray(data: data).completion?.first else {completion(false); return}
            completion(true)
            return
        })
        task.resume()
    }
    
    class func getPick(tid:String, week:String, completion: @escaping (PickModel?) -> ()) {
        let url:URL = URL(string: prefix + "MobileGetPicks.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "TID=\(tid)&Week=\(week)"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let d = data else {completion(nil);return}
            guard let results = Serializer.serializeDataArray(data: d).completion else {completion(nil); return}
            guard let t = results.first?["team"] as? String else {completion(nil); return}
            let p = PickModel(teamNumber: t)
            completion(p)
        })
        task.resume()

    }
}
