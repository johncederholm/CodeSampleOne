//
//  PrivateLeagueController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol LeagueControllerDelegate: class {
    func typeOfLeague() -> LeagueType?
}

class LeagueController:ShadowController {
    @IBOutlet weak var topLabel: BottomBorderLabel!
    @IBOutlet weak var leagueTableView: UITableView!
    @IBOutlet weak var leagueStandingsButton: UIButton!
    
    var delegate:LeagueControllerDelegate?
    var leagues = [LeagueModel]()
    override func viewDidLoad() {
        createTest()
        if let leagueType = delegate?.typeOfLeague() {
            switch leagueType {
            case .privateLeague:
                topLabel.text = "Private League"
            case .publicLeague:
                topLabel.text = "Public League"
            }
        }
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        leagueStandingsButton.addTarget(self, action: #selector(LeagueController.standingsButton(sender:)), for: .touchUpInside)
    }
    
    deinit {
        print("LeageControllerDeinit")
    }
    
    func standingsButton(sender:UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueStandingsController") as? LeagueStandingsController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createTest() {
        let testModel = LeagueModel(name: "Team1", type: .privateLeague, number: 0)
        leagues = [testModel]
    }
}

extension LeagueController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TeamCell {
            cell.setCell(model: leagues[indexPath.row])
        }
    }
    
    
}

extension LeagueController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") {
            return tableCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
