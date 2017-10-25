//
//  PrivateLeagueController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

protocol LeagueControllerDelegate: class {
    func selectedLeague() -> LeagueModel?
}

class LeagueController:ShadowController {
    @IBOutlet weak var topLabel: BottomBorderLabel!
    @IBOutlet weak var leagueTableView: UITableView!
    @IBOutlet weak var leagueStandingsButton: UIButton!
//    @IBOutlet weak var adBanner: GADBannerView!
    
    var interstitial:GADInterstitial!
    var showInterstitial:Bool = true
    var delegate:LeagueControllerDelegate?
    var teams:[TeamModel]?
    var selectedTeam:TeamModel?
    var league:LeagueModel {
        get {
            return delegate?.selectedLeague() ?? LeagueModel(name: "", type: .privateClassicLeague, lid: "")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        leagueStandingsButton.addTarget(self, action: #selector(LeagueController.standingsButton(sender:)), for: .touchUpInside)
//        adBanner.adUnitID = testAd
//        adBanner.adUnitID = adString
//        adBanner.rootViewController = self
//        adBanner.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTable()
        determineAd()
    }
    
    func determineAd() {
        if self.showInterstitial {
//            createAd()
        } else {
            self.showInterstitial = true
        }
    }
    
    func createAd() {
        interstitial = GADInterstitial(adUnitID: realInterstitial)
//        interstitial = GADInterstitial(adUnitID: testInterstitial)
        interstitial.delegate = self
        interstitial.load(GADRequest())
    }
    
    func setTable() {
        topLabel.text = delegate?.selectedLeague()?.name
        guard let lid = self.delegate?.selectedLeague()?.lid else {return}
        self.showLoadingScreen()
        TeamAPI.getTeamObjects(UID: LoginAPI.shared.UID, LID:lid, completion: {teams in
            DispatchQueue.main.sync {
                self.removeLoadingScreen()
                self.teams = teams
                self.leagueTableView.reloadData()
            }
        })
    }

    func standingsButton(sender:UIButton) {
        var ivc:String!
        guard let type = delegate?.selectedLeague()?.type else {return}
        switch type {
        case .privateClassicLeague:
            ivc = "LeagueStandingsController"
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ivc) as! LeagueStandingsController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case .privatePointsLeague:
            ivc = "PointsController"
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ivc) as! PointsController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case .publicClassicLeague:
            ivc = "LeagueStandingsController"
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ivc) as! LeagueStandingsController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case .publicPointsLeague:
            ivc = "PointsController"
            let vc = self.storyboard?.instantiateViewController(withIdentifier: ivc) as! PointsController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LeagueController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TeamCell {
            cell.setCell(model: (teams ?? [])[indexPath.section])
        }
    }
}

extension LeagueController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (teams ?? []).count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sec = indexPath.section
        guard let teams = self.teams else {return}
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeekController") as? WeekController else {return}
        selectedTeam = teams[sec]
        if selectedTeam?.isOut == true {return}
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension LeagueController:LeagueStandingsDelegate {
    func leagueID(lc:LeagueStandingsController) -> String {
        return delegate?.selectedLeague()?.lid ?? ""
    }
}

extension LeagueController:PointsDelegate {
    func leagueID(pc:PointsController) -> String {
        return delegate?.selectedLeague()?.lid ?? ""
    }
}

extension LeagueController:WeekControllerDelegate {
    func getLeague() -> LeagueModel {
        return self.league
    }
    
    func getTeam() -> TeamModel {
        return selectedTeam ?? TeamModel(name: "", id: "", isOut:false, isPicked:false, currentWeek: "1", teamName:nil)
    }
}

extension LeagueController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        interstitial.present(fromRootViewController: self)
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        self.showInterstitial = false
    }
}
