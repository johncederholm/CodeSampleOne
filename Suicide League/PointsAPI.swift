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
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {return}
            guard let results = Serializer.serializeDataArray(data: data).completion else {return}
            var points = [PointsModel]()
            for result in results {
                guard let name = result["teamName"] as? String else {continue}
                guard let score = result["score"] as? String else {continue}
                points.append(PointsModel(name: name, score: score))
            }
            return completion(createRanks(points: points))
        })
        task.resume()
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
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            guard let data = data else {completion([]);return}
            print(String.init(data: data, encoding: .utf8))
            guard let results = Serializer.serializeDataArray(data: data).completion else {completion([]);return}
            var standings = [StandingsModel]()
            var ins = [String]()
            var outs = [String]()
            var outIndex = 0
            for result in results {
                guard let name = result["teamName"] as? String else {continue}
                guard let isIn = result["active"] as? String else {continue}
                if isIn == "1" {
                    outs.append(name)
                } else if isIn == "0" {
                    ins.append(name)
                }
            }
            if ins.count > outs.count {
                for inName in ins {
                    var outName:String? = nil
                    if outs.indices.contains(outIndex) {
                        outName = outs[outIndex]
                        outIndex += 1
                    }
                    let standing = StandingsModel(inTeamName: inName, outTeamName: outName)
                    standings.append(standing)
                }
            } else if ins.count < outs.count {
                for outName in outs {
                    var inName:String? = nil
                    if ins.indices.contains(outIndex) {
                        inName = ins[outIndex]
                        outIndex += 1
                    }
                    let standing = StandingsModel(inTeamName: inName, outTeamName: outName)
                    standings.append(standing)
                }
            } else {
                for inName in ins {
                    var outName:String? = nil
                    if outs.indices.contains(outIndex) {
                        outName = outs[outIndex]
                        outIndex += 1
                    }
                    let standing = StandingsModel(inTeamName: inName, outTeamName: outName)
                    standings.append(standing)
                }
            }
            return completion(standings)
        })
        task.resume()
    }
}
