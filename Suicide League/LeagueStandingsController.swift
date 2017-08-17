//
//  LeagueStandingsController.swift
//  Suicide League
//
//  Created by John Cederholm on 8/5/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol LeagueStandingsDelegate:class {
    func leagueID(lc:LeagueStandingsController) -> String
}

class LeagueStandingsController:ShadowController {
    @IBOutlet weak var standingsTable: UITableView!
    var delegate:LeagueStandingsDelegate?
    var standings = [StandingsModel]()
    
    override func viewDidLoad() {
        standingsTable.delegate = self
        standingsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let lid = delegate?.leagueID(lc: self) else {return}
        PointsAPI.getStandings(lid: lid, completion: {standings in
            self.standings = standings
            DispatchQueue.main.async {
                self.standingsTable.reloadData()
            }
        })
    }
}

extension LeagueStandingsController:UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}

extension LeagueStandingsController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsCell") as? StandingsCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let standing = standings[indexPath.row]
        if let cell = cell as? StandingsCell {
            cell.setCell(model: standing)
        }
    }

}
