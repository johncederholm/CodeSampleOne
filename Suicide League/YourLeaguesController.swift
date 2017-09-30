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
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var joinPrivate: UIButton!
    @IBOutlet weak var yourLeagueLabel: BottomBorderLabel!
    
    var leagueToPass:LeagueModel!
    var leagues = [LeagueModel]()
    var rightButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"header")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: UIBarPosition.top, barMetrics: .default)
        let logoTitle = UIImageView(image: UIImage(named:"hLogo"))
        logoTitle.frame.size.height = 44
        logoTitle.backgroundColor = UIColor.red
        logoTitle.contentMode = .scaleAspectFit
        
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        joinPrivate.addTarget(self, action: #selector(YourLeaguesController.joinLeague), for: .touchUpInside)
        let rButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rButton.setBackgroundImage(UIImage(named:"settings"), for: .normal)
        rButton.backgroundColor = UIColor.clear
        rButton.addTarget(self, action: #selector(YourLeaguesController.showOptions), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: rButton)
        rightButton.action = #selector(YourLeaguesController.showOptions)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LoginAPI.shared.UID.isEmpty {
            self.leagues = []
            self.leaguesTableView.reloadData()
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as? UINavigationController {
                self.present(vc, animated: true, completion: {done in
                    if let lvc = vc.viewControllers[0] as? LoginController {
                        lvc.delegate = self
                    }
                })
            }
        } else {
            self.setLeagues(UID:LoginAPI.shared.UID)
        }
    }
    
    func showOptions() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionsController") as! OptionsController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setLeagues(UID:String) {
        self.showLoadingScreen()
        LeagueAPI.getLeagueObjects(UID: UID, completion: {complete in
            DispatchQueue.main.sync {
                self.removeLoadingScreen()
                guard let complete = complete else {return}
                self.leagues = complete
                self.leaguesTableView.reloadData()
            }
        })
    }
    
    func leagueButtonPress(sender: LeagueButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueController") as? LeagueController else {return}
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func joinLeague() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "JoinLeagueController") as? JoinLeagueController else {return}
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension YourLeaguesController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension YourLeaguesController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") {return cell}
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? LeagueCell {
            cell.setCell(league:leagues[indexPath.section])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView()
        backView.backgroundColor = UIColor.clear
        return backView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ivc = "LeagueController"
        if let lc = self.storyboard?.instantiateViewController(withIdentifier: ivc) as? LeagueController {
            self.leagueToPass = self.leagues[indexPath.section]
            lc.delegate = self
            self.navigationController?.pushViewController(lc, animated: true)
        }
    }
}

extension YourLeaguesController:LeagueControllerDelegate {
    func selectedLeague() -> LeagueModel? {
        guard let sl = self.leagueToPass else {return nil}
        return sl
    }
}

extension YourLeaguesController:JoinLeagueDelegate {
    
}

extension YourLeaguesController:LoginControllerDelegate {
    func wasLoggedIn(controller: LoginController) {
        self.leaguesTableView.reloadData()
    }
}

extension YourLeaguesController:OptionsDelegate {
    func didLogout() {
        self.leaguesTableView.reloadData()
    }
}
