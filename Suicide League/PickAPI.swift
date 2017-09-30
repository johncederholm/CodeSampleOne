//
//  PickAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/12/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

enum PickResponse:String {
    case success = "200"
    case teamPicked = "301"
    case noLeague = "400"
    case pastWeek = "401"
    case wrongPassword = "402"
    case noPassword = "403"
}

class PickAPI {
    class func makePick(uid:String, lid:String, tid:String, pick:String, pickweek:String, completion: @escaping (PickResponse?, String?) -> ()) {
        let url:URL = URL(string: prefix + "MobileMakePicks.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "ShowUID=\(uid)&ShowLID=\(lid)&ShowTID=\(tid)&Pick=\(pick)&PickWeek=\(pickweek)"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if data?.isEmpty == true {

            }
            let errorMessage = "There was a server error. Try again in a bit."
            guard let data = data else {completion(nil, errorMessage);return}
            guard let results = Serializer.serializeDataArray(data: data).completion?.first else {completion(nil, errorMessage); return}
            var message:String? = nil
            guard let resp = results["response"] as? String else {completion(nil, errorMessage);return}
            let responsePick = PickResponse(rawValue: resp)
            if let week = results["week"] as? String, let team = results["team"] as? String {
                let teamModel = NFLModel.getTeam(teamNumber: team)
                message = "The " + teamModel.name + " were already picked week \(week)"
                completion(responsePick, message)
                return
            }
            if let responsePick = responsePick {
                switch responsePick {
                case .pastWeek:
                    message = "This week has already been played."
                default: break
                }
            }
            completion(responsePick, message)
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
