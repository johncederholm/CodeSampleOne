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
        
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            guard let results = Serializer.serializeDataArray(data: data).completion else {completion(nil); return}
            var teams = [TeamModel]()
            for r in results {
                guard let name = r["teamName"] as? String else {continue}
                guard let tid = r["teamID"] as? String else {continue}
                guard let a = r["active"] as? String else {continue}
                guard let cw = r["currentWeek"] as? Int else {continue}
                var isPicked = false
                if let p = r["isPicked"] as? Bool {
                    isPicked = p
                }
                var tn:String? = nil
                if let teamName = r["pickName"] as? String {
                    if !teamName.isEmpty {
                        tn = teamName
                    }
                }
                let t = TeamModel(name: name, id: tid, isOut: a == "1" ? true : false, isPicked: isPicked, currentWeek: String(cw), teamName: tn)
                teams.append(t)
            }
            completion(teams)
        }, fa: {failure in
            completion(nil)
        })
    }
}
