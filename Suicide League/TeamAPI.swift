//
//  TeamAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class TeamAPI {
    class func getTeamObjects(UID:String, LID:String, completion: @escaping ([TeamModel]?) -> ()) {
        let url:URL = URL(string: prefix + "MobileTeams.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "UID=\(UID)&LID=\(LID)"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion(nil);return}
            guard let results = Serializer.serializeDataArray(data: data).completion else {completion(nil); return}
            var teams = [TeamModel]()
            for r in results {
                guard let name = r["teamName"] as? String else {continue}
                guard let tid = r["teamID"] as? String else {continue}
                guard let a = r["active"] as? String else {continue}
                
                let t = TeamModel(name: name, id: tid, isOut: a == "1" ? true : false)
                teams.append(t)
            }
            completion(teams)
        })
        task.resume()
    }
}
