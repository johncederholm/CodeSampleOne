//
//  WeekController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class WeekController:ShadowController {
    @IBOutlet weak var teamLabel: BottomBorderLabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var weekTableView: UITableView!
    var weeks = [WeekModel]()
    
    override func viewDidLoad() {
        createTest()
        weekTableView.delegate = self
        weekTableView.dataSource = self
    }
    
    func createTest() {
        let lc:[UIColor] = [.blue, .red]
        let rc:[UIColor] = [.brown, .orange]
        let ltc = "Cleveland"
        let ltn = "Browns"
        let d = "05/14/17"
        let t = "4:58PM EST"
        let rtc = "Baltimore"
        let rtn = "Ravens"
        let week = WeekModel(ltc: ltc, ltn: ltn, lc: lc, d: d, t: t, rtc: rtc, rtn: rtn, rc: rc)
        weeks = [week]
    }
}

extension WeekController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? WeekCell {
            cell.setCell(model: weeks[indexPath.section])
        }
    }
    
    
}
extension WeekController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return weeks.count
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
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: "WeekCell") {
            return tableCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
