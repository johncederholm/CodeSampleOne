//
//  HomeAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/7/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

enum LeagueResponse:String {
    case success = "200"
    case teamExists = "300"
    case noLeague = "400"
    case noLeagueID = "401"
    case wrongPassword = "402"
    case noPassword = "403"
}

class LeagueAPI {
    class func getLeagueObjects(UID:String, completion: @escaping ([LeagueModel]?) -> ()) {
        let url:URL = URL(string: prefix + "MobileLeagues.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "UID=\(UID)"
        request.httpBody = bodyData.data(using: .utf8)
        
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            guard let results = Serializer.serializeDataArray(data: data).completion else {completion(nil);return}
            var leagues = [LeagueModel]()
            for r in results {
                guard let name = r["name"] as? String else {continue}
                guard let t = r["type"] as? String else {continue}
                var type:LeagueType!
                switch t {
                case "1": type = LeagueType.privateClassicLeague
                case "2": type = LeagueType.publicClassicLeague
                case "3": type = LeagueType.publicPointsLeague
                case "4": type = LeagueType.privatePointsLeague
                default: type = LeagueType.privateClassicLeague
                }
                guard let lid = r["leagueID"] as? String else {continue}
                let l = LeagueModel(name: name, type: type, lid: lid)
                leagues.append(l)
            }
            completion(leagues)
            return
        }, fa: {failure in
            completion(nil)
            return
        })
        
        
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
//            guard let data = data else {completion(nil);return}
//            guard let results = Serializer.serializeDataArray(data: data).completion else {completion(nil); return}
//            var leagues = [LeagueModel]()
//            for r in results {
//                guard let name = r["name"] as? String else {continue}
//                guard let t = r["type"] as? String else {continue}
//                var type:LeagueType!
//                switch t {
//                case "1": type = LeagueType.privateClassicLeague
//                case "2": type = LeagueType.publicClassicLeague
//                case "3": type = LeagueType.publicPointsLeague
//                case "4": type = LeagueType.privatePointsLeague
//                default: type = LeagueType.privateClassicLeague
//                }
//                guard let lid = r["leagueID"] as? String else {continue}
//                let l = LeagueModel(name: name, type: type, lid: lid)
//                leagues.append(l)
//            }
//            completion(leagues)
//        })
//        task.resume()
    }
    
    class func joinLeague(UID:String, LID:String, teamName:String, password:String?, completion:@escaping (String, LeagueResponse?) -> ()) {
        let url:URL = URL(string: prefix + "MobileJoinLeague.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "UID=\(UID)&LID=\(LID)&TeamName=\(teamName)&Password=\(password)"
        request.httpBody = bodyData.data(using: .utf8)
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            guard let results = Serializer.serializeDataArray(data: data).completion?.first else {completion("serialization", nil); return}
            guard let resp = results["response"] as? String else {completion("resp", nil);return}
            guard let response = LeagueResponse(rawValue:resp) else {completion("respEnum", nil);return}
            switch response {
            case .success:
                completion("Success", response)
                return
            case .teamExists:
                completion("Team already exists.", response)
                return
            default: completion("error", response)
                return
            }
        }, fa: {failure in
            completion("no data", nil)
        })
    }
}
