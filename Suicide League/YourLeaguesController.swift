//
//  YourLeaguesController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class YourLeaguesController:ShadowController {
    @IBOutlet weak var publicButton: LeagueButton!
    @IBOutlet weak var privateButton: LeagueButton!
    
    @IBOutlet weak var joinPrivate: UIButton!
    @IBOutlet weak var yourLeagueLabel: BottomBorderLabel!
    
    var selectedType:LeagueType!
    
    override func viewDidLoad() {
        publicButton.addTarget(self, action: #selector(YourLeaguesController.leagueButtonPress(sender:)), for: .touchUpInside)
        privateButton.addTarget(self, action: #selector(YourLeaguesController.leagueButtonPress(sender:)), for: .touchUpInside)
    }
    
    func leagueButtonPress(sender: LeagueButton) {
        guard let leagueType = sender.leagueType else {return}
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueController") as? LeagueController else {return}
        vc.delegate = self
        self.selectedType = leagueType
        self.navigationController?.pushViewController(vc, animated: true)
        var newRequest = URL(string: "http://suicideleague.com/v6/ShowTeamAndMakePicks.php")!
        var newR = URLRequest(url: newRequest)
        newR.httpMethod = "POST"
        let bd = "ShowTID=39676&ShowUID=25533&ShowLID=15046"
        newR.httpBody = bd.data(using: .utf8)
        NSURLConnection.sendAsynchronousRequest(newR, queue: .main, completionHandler: {r, d, e in
            let xml:String = String(data: d!, encoding: String.Encoding.utf8)
            do {
                let document = try XMLDocument(string: xml)
                if let root = document.root {
                    for element in root.children {
                        print("\(element.tag): \(element.attributes)")
                    }
                }
            }
        })
    }
}

extension YourLeaguesController:LeagueControllerDelegate {
    func typeOfLeague() -> LeagueType? {
        guard let leagueType = self.selectedType else {return nil}
        return leagueType
    }
}
