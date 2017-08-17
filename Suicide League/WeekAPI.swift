//
//  WeekAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class WeekAPI {
    class func getLeagueObjects(week:String, completion: @escaping ([WeekModel]?) -> ()) {
        let url:URL = URL(string: prefix + "MobileWeeks.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "Week=\(week)"
        request.httpBody = bodyData.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion(nil);return}
            guard let results = Serializer.serializeDataArray(data: data).completion else {completion(nil); return}
            var weeks = [WeekModel]()
            for r in results {
                guard let home = r["home"] as? String else {continue}
                guard let away = r["away"] as? String else {continue}
                guard let time = r["date_time"] as? String else {continue}
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
                guard let date = dateFormatter.date(from: time) else {continue}
                let ht = NFLModel.getTeam(teamNumber: home)
                let at = NFLModel.getTeam(teamNumber: away)
                
                let tF = DateFormatter()
                tF.timeZone = TimeZone(identifier: "America/New_York")
                tF.dateFormat = "h:mm a"
                let uT = tF.string(from: date)
                
                let dF = DateFormatter()
                dF.timeZone = TimeZone(identifier: "America/New_York")
                dF.dateFormat = "M-d-yy"
                let uD = dF.string(from: date)
                
                let w = WeekModel(ltn:at.name, lc:at.colors, d: uD, t: uT, rtn: ht.name, rc: ht.colors, ln: away, rn: home)
                weeks.append(w)
            }
            completion(weeks)
        })
        task.resume()
    }
}
