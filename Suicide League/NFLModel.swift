//
//  NFLModel.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class NFLModel {
    var name:String
    var pic:UIImage
    var colors:[UIColor]
    var id:String
    init(name:String, pic:UIImage, colors:[UIColor], id:String) {
        self.name = name
        self.pic = pic
        self.colors = colors
        self.id = id
    }
    class func getTeam(teamNumber:String) -> NFLModel {
        var name = ""
        var pic = UIImage()
        var colors = [UIColor]()
        switch teamNumber {
            case "1":
            name = "Arizona\nCardinals"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#9B2743")
            let sc = UIColor.hexStringToUIColor(hex: "#FFCD00")
            colors = [fc, sc]
        case "2":
            name = "Atlanta\nFalcons"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#A6192E")
            let sc = UIColor.hexStringToUIColor(hex: "#101820")
            colors = [fc, sc]
        case "4":
            name = "Baltimore\nRavens"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#241773")
            let sc = UIColor.hexStringToUIColor(hex: "#101820")
            colors = [fc, sc]
        case "5":
            name = "Buffalo\nBills"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#00338D")
            let sc = UIColor.hexStringToUIColor(hex: "#C8102E")
            colors = [fc, sc]
        case "6":
            name = "Carolina\nPanthers"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#0085CA")
            let sc = UIColor.hexStringToUIColor(hex: "#101820")
            colors = [fc, sc]
        case "7":
            name = "Chicago\nBears"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#051C2C")
            let sc = UIColor.hexStringToUIColor(hex: "#DC4405")
            colors = [fc, sc]
        case "8":
            name = "Cincinnati\nBengals"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#FC4C02")
            let sc = UIColor.hexStringToUIColor(hex: "#101820")
            colors = [fc, sc]
        case "9":
            name = "Cleveland\nBrowns"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#382F2D")
            let sc = UIColor.hexStringToUIColor(hex: "#EB3300")
            colors = [fc, sc]
        case "10":
            name = "Dallas\nCowboys"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#041E42")
            let sc = UIColor.hexStringToUIColor(hex: "#7F9695")
            colors = [fc, sc]
        case "11":
            name = "Denver\nBroncos"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#FC4C02")
            let sc = UIColor.hexStringToUIColor(hex: "#0C2340")
            colors = [fc, sc]
        case "12":
            name = "Detroit\nLions"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#0069B1")
            let sc = UIColor.hexStringToUIColor(hex: "#A2AAAD")
            colors = [fc, sc]
        case "13":
            name = "Green Bay\nPackers"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#175E33")
            let sc = UIColor.hexStringToUIColor(hex: "#FFB81C")
            colors = [fc, sc]
        case "14":
            name = "Houston\nTexans"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#091F2C")
            let sc = UIColor.hexStringToUIColor(hex: "#A6192E")
            colors = [fc, sc]
        case "15":
            name = "Indianapolis\nColts"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#001489")
            let sc = UIColor.hexStringToUIColor(hex: "#FFFFFF")
            colors = [fc, sc]
        case "16":
            name = "Jacksonville\nJaguars"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#D49F12")
            let sc = UIColor.hexStringToUIColor(hex: "#006073")
            colors = [fc, sc]
        case "17":
            name = "Kansas City\nChiefs"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#C8102E")
            let sc = UIColor.hexStringToUIColor(hex: "#FFB81C")
            colors = [fc, sc]
        case "18":
            name = "Miami\nDolphins"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#008E97")
            let sc = UIColor.hexStringToUIColor(hex: "#F58220")
            colors = [fc, sc]
        case "19":
            name = "Minnesota\nVikings"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#512D6D")
            let sc = UIColor.hexStringToUIColor(hex: "#FFB81C")
            colors = [fc, sc]
        case "20":
            name = "New England\nPatriots"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#0C2340")
            let sc = UIColor.hexStringToUIColor(hex: "#C8102E")
            colors = [fc, sc]
        case "21":
            name = "New Orleans\nSaints"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#A28D5B")
            let sc = UIColor.hexStringToUIColor(hex: "#101920")
            colors = [fc, sc]
        case "22":
            name = "New York\nGiants"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#001E62")
            let sc = UIColor.hexStringToUIColor(hex: "#A6192E")
            colors = [fc, sc]
        case "23":
            name = "New York\nJets"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#0C371D")
            let sc = UIColor.hexStringToUIColor(hex: "#FFFFFF")
            colors = [fc, sc]
        case "24":
            name = "Oakland\nRaiders"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#101820")
            let sc = UIColor.hexStringToUIColor(hex: "#A5ACAF")
            colors = [fc, sc]
        case "25":
            name = "Philadelphia\nEagles"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#004851")
            let sc = UIColor.hexStringToUIColor(hex: "#101820")
            colors = [fc, sc]
        case "26":
            name = "Pittsburgh\nSteelers"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#FFB81C")
            let sc = UIColor.hexStringToUIColor(hex: "#101820")
            colors = [fc, sc]
        case "27":
            name = "Los Angeles\nChargers"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#0C2340")
            let sc = UIColor.hexStringToUIColor(hex: "#FFB81C")
            colors = [fc, sc]
        case "28":
            name = "San Fransisco\n49ers"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#9B2743")
            let sc = UIColor.hexStringToUIColor(hex: "#896C4C")
            colors = [fc, sc]
        case "29":
            name = "Seattle\nSeahawks"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#4DFF00")
            let sc = UIColor.hexStringToUIColor(hex: "#245998")
            colors = [fc, sc]
        case "30":
            name = "Los Angeles\nRams"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#002244")
            let sc = UIColor.hexStringToUIColor(hex: "#FFFFFF")
            colors = [fc, sc]
        case "31":
            name = "Tampa Bay\nBuccaneers"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#C8102E")
            let sc = UIColor.hexStringToUIColor(hex: "#FF8200")
            colors = [fc, sc]
        case "32":
            name = "Tennessee\nTitans"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#0C2340")
            let sc = UIColor.hexStringToUIColor(hex: "#4B92DB")
            colors = [fc, sc]
        case "33":
            name = "Washington\nRedskins"
            pic = UIImage()
            let fc = UIColor.hexStringToUIColor(hex: "#862633")
            let sc = UIColor.hexStringToUIColor(hex: "#FFCD00")
            colors = [fc, sc]
        default:break
        }
        return NFLModel(name: name, pic: pic, colors: colors, id:teamNumber)
    }
}
