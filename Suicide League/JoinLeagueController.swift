//
//  JoinLeagueController.swift
//  Suicide League
//
//  Created by John Cederholm on 8/5/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol JoinLeagueDelegate:class {
    
}

class JoinLeagueController:ShadowController {
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var teamNameField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var delegate:JoinLeagueDelegate?
    
    override func viewDidLoad() {
        submitButton.addTarget(self, action: #selector(JoinLeagueController.submitLeague(sender:)), for: .touchUpInside)
    }
    
    func submitLeague(sender:AnyObject) {
        guard let n = nameField.text else {noNameMessage();return}
        guard let tn = teamNameField.text else {noTeamNameMessage();return}
        let u = LoginAPI.shared.UID
        if n.isEmpty {noNameMessage();return}
        if tn.isEmpty {noTeamNameMessage();return}
        if u.isEmpty {return}
        var p:String? = nil
        if let pword = passwordField.text {
            p = pword
        }
        LeagueAPI.joinLeague(UID: u, LID: n, teamName: tn, password: p, completion: {done in
            print(done)
            if done == "good" {
                DispatchQueue.main.async {
                    self.successMessage()
                }
            } else if done == "exists" {
                DispatchQueue.main.async {
                    self.teamNameTaken()
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage()
                }
            }
        })
    }
    
    func successMessage() {
        let alert = UIAlertController(title: "Success", message: "You successfully joined the league.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func teamNameTaken() {
        let alert = UIAlertController(title: "Team Name Taken", message: "That team name is taken for this league. Try again with a different name.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorMessage() {
        let alert = UIAlertController(title: "Error", message: "There was an error. Try again later.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noNameMessage() {
        let alert = UIAlertController(title: "Error", message: "Add a League ID", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func noTeamNameMessage() {
        let alert = UIAlertController(title: "Error", message: "Add a Team Name.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
