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
            colors = [.red, .white]
        case "2":
            name = "Atlanta\nFalcons"
            pic = UIImage()
            colors = [.red, .black]
        case "4":
            name = "Baltimore\nRavens"
            pic = UIImage()
            colors = [.purple, .black]
        case "5":
            name = "Buffalo\nBills"
            pic = UIImage()
            colors = [.red, .blue]
        case "6":
            name = "Carolina\nPanthers"
            pic = UIImage()
            colors = [.blue, .black]
        case "7":
            name = "Chicago\nBears"
            pic = UIImage()
            colors = [.blue, .orange]
        case "8":
            name = "Cincinnati\nBengals"
            pic = UIImage()
            colors = [.orange, .black]
        case "9":
            name = "Cleveland\nBrowns"
            pic = UIImage()
            colors = [.brown, .orange]
        case "10":
            name = "Dallas\nCowboys"
            pic = UIImage()
            colors = [.blue, .gray]
        case "11":
            name = "Denver\nBroncos"
            pic = UIImage()
            colors = [.blue, .orange]
        case "12":
            name = "Detroit\nLions"
            pic = UIImage()
            colors = [.blue, .gray]
        case "13":
            name = "Green Bay\nPackers"
            pic = UIImage()
            colors = [.green, .yellow]
        case "14":
            name = "Houston\nTexans"
            pic = UIImage()
            colors = [.red, .blue]
        case "15":
            name = "Jacksonville\nJaguars"
            pic = UIImage()
            colors = [.black, .cyan]
        case "16":
            name = "Indianapolis\nColts"
            pic = UIImage()
            colors = [.blue, .gray]
        case "17":
            name = "Kansas City\nChiefs"
            pic = UIImage()
            colors = [.red, .yellow]
        case "18":
            name = "Miami\nDolphins"
            pic = UIImage()
            colors = [.orange, .cyan]
        case "19":
            name = "Minnesota\nVikings"
            pic = UIImage()
            colors = [.yellow, .purple]
        case "20":
            name = "New England\nPatriots"
            pic = UIImage()
            colors = [.blue, .red]
        case "21":
            name = "New Orleans\nSaints"
            pic = UIImage()
            colors = [.yellow, .black]
        case "22":
            name = "New York\nGiants"
            pic = UIImage()
            colors = [.red, .blue]
        case "23":
            name = "New York\nJets"
            pic = UIImage()
            colors = [.green, .white]
        case "24":
            name = "Oakland\nRaiders"
            pic = UIImage()
            colors = [.gray, .black]
        case "25":
            name = "Philadelphia\nEagles"
            pic = UIImage()
            colors = [.green, .white]
        case "26":
            name = "Pittsburgh\nSteelers"
            pic = UIImage()
            colors = [.black, .yellow]
        case "27":
            name = "Los Angeles\nChargers"
            pic = UIImage()
            colors = [.blue, .white]
        case "28":
            name = "San Fransisco\n49ers"
            pic = UIImage()
            colors = [.yellow, .red]
        case "29":
            name = "Seattle\nSeahawks"
            pic = UIImage()
            colors = [.blue, .green]
        case "30":
            name = "Los Angeles\nRams"
            pic = UIImage()
            colors = [.blue, .yellow]
        case "31":
            name = "Tampa Bay\nBuccaneers"
            colors = [.red, .gray]
            pic = UIImage()
        case "32":
            name = "Tennessee\nTitans"
            colors = [.blue, .white]
            pic = UIImage()
        case "33":
            name = "Washington\nRedskins"
            pic = UIImage()
            colors = [.red, .yellow]
        default:break
        }
        return NFLModel(name: name, pic: pic, colors: colors, id:teamNumber)
    }
}
