//
//  PointsController.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol PointsDelegate:class {
    func leagueID(pc:PointsController) -> String
}

class PointsController:ShadowController {
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsTable: UITableView!
    
    var delegate:PointsDelegate?
    var points:[PointsModel]?
    
    override func viewDidLoad() {
        pointsTable.delegate = self
        pointsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let lid = delegate?.leagueID(pc: self) else {return}
        PointsAPI.getPoints(LID: lid, completion: {points in
            self.points = points
            DispatchQueue.main.async {
                self.setTable()
            }
        })
    }
    
    func setTable() {
        pointsTable.reloadData()
    }
}

extension PointsController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PointsCell") as? PointsCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let point = points?[indexPath.row], let cell = cell as? PointsCell {
            cell.setCell(model: point)
        }
    }
}

extension PointsController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = tableView.bounds.width / 3
        let height:CGFloat = 20
        let y:CGFloat = 0
        let x:CGFloat = 0
        let headerView = UIView(frame: CGRect(x: x, y: y, width: width * 3, height: height))
        let hWidth = headerView.bounds.width / 3
        let leftLabel = UILabel(frame: CGRect(x: x, y: y, width: hWidth, height: height))
        let middleLabel = UILabel(frame: CGRect(x: width, y: y, width: hWidth, height: height))
        let rightLabel = UILabel(frame:CGRect(x: width * 2, y: y, width: hWidth, height: height))
        leftLabel.textColor = UIColor.lightGray
        leftLabel.textAlignment = .center
        middleLabel.textColor = UIColor.lightGray
        middleLabel.textAlignment = .center
        rightLabel.textColor = UIColor.lightGray
        rightLabel.textAlignment = .center
        leftLabel.text = "Rank"
        middleLabel.text = "Name"
        rightLabel.text = "Points"
        headerView.addSubview(leftLabel)
        headerView.addSubview(middleLabel)
        headerView.addSubview(rightLabel)
        headerView.backgroundColor = UIColor(red: 0.098, green: 0.098, blue: 0.098, alpha: 1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points?.count ?? [].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
