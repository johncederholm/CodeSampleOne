//
//  PointsAPI.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation

class PointsAPI {
    class func getPoints(LID: String, completion: @escaping ([PointsModel]) -> ()) {
        let url:URL = URL(string: prefix + "MobilePoints.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "LID=\(LID)"
        request.httpBody = bodyData.data(using: .utf8)
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            guard let results = Serializer.serializeDataArray(data: data).completion else {return}
            var points = [PointsModel]()
            for result in results {
                guard let name = result["teamName"] as? String else {continue}
                guard let score = result["score"] as? String else {continue}
                guard let uid = result["userID"] as? String else {continue}
                var isSelf = false
                if uid == LoginAPI.shared.UID {
                    isSelf = true
                }
                points.append(PointsModel(name: name, score: score, isSelf: isSelf))
            }
            return completion(createRanks(points: points))
        }, fa: {failure in
            completion([])
        })
    }
    
    class func createRanks(points:[PointsModel]) -> [PointsModel] {
        let sortedPoints = points.sorted{
            return (Double($0.score) ?? 0) > (Double($1.score) ?? 0)
        }
        var amountArray = [Double]()
        for point in sortedPoints {
            let p = Double(point.score) ?? 0
            if !amountArray.contains(p) {
                amountArray.append(p)
            }
        }
        for point in sortedPoints {
            let p = Double(point.score) ?? 0
            guard let rank = amountArray.index(of: p) else {continue}
            point.rank = rank + 1
        }
        return sortedPoints
    }
    
    class func getStandings(lid:String, completion:@escaping ([StandingsModel]) -> ()) {
        let url:URL = URL(string: prefix + "MobileLeagueStandings.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "LID=\(lid)"
        request.httpBody = bodyData.data(using: .utf8)
        FailableTask.run(u: url, mt: "POST", b: bodyData, r: 3, s: URLSession.shared, suc: {data in
            guard let results = Serializer.serializeDataArray(data: data).completion else {completion([]);return}
            var standings = [StandingsModel]()
            var ins = [String]()
            var outs = [String]()
            var teamNames = [String]()
            var outIndex = 0
            for result in results {
                guard let name = result["teamName"] as? String else {continue}
                guard let isIn = result["active"] as? String else {continue}
                guard let uid = result["userID"] as? String else {continue}
                if uid == LoginAPI.shared.UID {
                    teamNames.append(name)
                }
                if isIn == "1" {
                    outs.append(name)
                } else if isIn == "0" {
                    ins.append(name)
                }
            }
            if ins.count > outs.count {
                for inName in ins {
                    var outName:String? = nil
                    var outIsSelf:Bool? = nil
                    if outs.indices.contains(outIndex) {
                        outName = outs[outIndex]
                        outIndex += 1
                        if let outName = outName {
                            if teamNames.contains(outName) {
                                outIsSelf = true
                            }
                        }
                    }
                    var inIsSelf = false
                    if teamNames.contains(inName) {
                        inIsSelf = true
                    }
                    let standing = StandingsModel(inTeamName: (inName, inIsSelf), outTeamName: (outName, outIsSelf))
                    standings.append(standing)
                }
            } else if ins.count < outs.count {
                for outName in outs {
                    var inName:String? = nil
                    var inIsSelf:Bool? = nil
                    if ins.indices.contains(outIndex) {
                        inName = ins[outIndex]
                        outIndex += 1
                        if let inName = inName {
                            if teamNames.contains(inName) {
                                inIsSelf = true
                            }
                        }
                    }
                    var outIsSelf = false
                    if teamNames.contains(outName) {
                        outIsSelf = true
                    }
                    let standing = StandingsModel(inTeamName: (inName, inIsSelf), outTeamName: (outName, outIsSelf))
                    standings.append(standing)
                }
            } else {
                for inName in ins {
                    var outName:String? = nil
                    var outIsSelf:Bool? = nil
                    if outs.indices.contains(outIndex) {
                        outName = outs[outIndex]
                        outIndex += 1
                        if let outName = outName {
                            if teamNames.contains(outName) {
                                outIsSelf = true
                            }
                        }
                    }
                    var inIsSelf = false
                    if teamNames.contains(inName) {
                        inIsSelf = true
                    }
                    let standing = StandingsModel(inTeamName: (inName, inIsSelf), outTeamName: (outName, outIsSelf))
                    standings.append(standing)
                }
            }
            return completion(standings)
        }, fa: {failure in
            completion([])
        })
    }
}
