//
//  WeekController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/30/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol WeekControllerDelegate:class {
    func getLeague() -> LeagueModel
    func getTeam() -> TeamModel
}

class WeekController:ShadowController {
    @IBOutlet weak var teamLabel: BottomBorderLabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var weekTableView: UITableView!
    @IBOutlet weak var weekSelector: UIView!
    var delegate:WeekControllerDelegate?
    var weeks:[WeekModel]?
    var picker:UIPickerView!
    var pickerButton:UIButton!
    var usableWeeks:[String]!
    var selectedWeek:String!
    var pick:PickModel?
    var tapView:UIView?
    
    override func viewDidLoad() {
        weekTableView.delegate = self
        weekTableView.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(WeekController.weekSelection))
        self.weekSelector.addGestureRecognizer(tap)
        arrowView.image = arrowView.image!.withRenderingMode(.alwaysTemplate)
        arrowView.tintColor = UIColor.lightGray
        self.usableWeeks = getWeeks()
        picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        pickerButton = UIButton()
        pickerButton.setTitle("Done", for: .normal)
        pickerButton.backgroundColor = UIColor.blue
        picker.backgroundColor = .purple
        pickerButton.addTarget(self, action: #selector(WeekController.selectRow(sender:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSchedule(week: "1")
    }
    
    func loadSchedule(week:String) {
        guard let team = delegate?.getTeam() else {return}
        selectedWeek = week
        weekLabel.text = "Week " + week
        WeekAPI.getLeagueObjects(week: week, completion: {models in
            self.weeks = models
            PickAPI.getPick(tid: team.id, week: week, completion: {pick in
                self.pick = pick
                DispatchQueue.main.async {
                    self.weekTableView.reloadData()
                }
            })
        })
    }
    
    func weekSelection() {
        if self.view.subviews.contains(self.picker) {return}
        self.picker.removeFromSuperview()
        self.pickerButton.removeFromSuperview()
        if self.tapView == nil {
            self.tapView = UIView(frame: self.view.bounds)
        }
        guard let tapView = self.tapView else {return}
        let t = UITapGestureRecognizer(target: self, action: #selector(WeekController.dismissPicker))
        tapView.addGestureRecognizer(t)
        tapView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.addSubview(tapView)
        let vb = self.view.bounds
        let height = vb.height / 3
        let tab = self.tabBarController?.tabBar.frame.height ?? 0
        let x:CGFloat = 0
        let y = vb.height - height - tab
        let buttonHeight:CGFloat = 40
        self.view.addSubview(picker)
        self.view.addSubview(pickerButton)
        picker.frame.origin = CGPoint(x: 0, y: vb.height)
        pickerButton.frame = CGRect(x: 0, y: vb.height, width: vb.width, height: buttonHeight)
        self.view.bringSubview(toFront: picker)
        self.view.bringSubview(toFront: pickerButton)
        UIView.animate(withDuration: 0.2, animations: {animation in
            self.picker.frame.origin = CGPoint(x: x, y: y)
            self.pickerButton.frame.origin = CGPoint(x: x, y: y - buttonHeight)
        }, completion: {completion in
        })
    }
    
    func selectRow(sender:AnyObject?) {
        let selectedRow = picker.selectedRow(inComponent: 0)
        if let del = picker.delegate {
            let val = del.pickerView!(picker, titleForRow: selectedRow, forComponent: 0) ?? ""
            self.loadSchedule(week: val)
        }
        dismissPicker()
    }
    
    func dismissPicker() {
        if tapView != nil {self.tapView?.removeFromSuperview()}
        let y = self.view.bounds.height
        let b = picker.bounds
        UIView.animate(withDuration: 0.2, animations: {animations in
            self.picker.frame = CGRect(x: 0, y: y, width: b.width, height: b.height)
            self.pickerButton.frame = CGRect(x: 0, y: y, width: b.width, height: b.height)
        }, completion: {completion in
            self.picker.removeFromSuperview()
            self.pickerButton.removeFromSuperview()
        })
    }
    
    func getWeeks() -> [String] {
        var weekArray = [String]()
        for i in 1..<18 {
            weekArray.append(String(i))
        }
        return weekArray
    }
}

extension WeekController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let weeks = weeks else {return}
        if let cell = cell as? WeekCell {
            cell.delegate = self
            cell.setCell(model: weeks[indexPath.section], pick:self.pick)
        }
    }
}
extension WeekController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (weeks ?? []).count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
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

extension WeekController:UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return usableWeeks.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return usableWeeks[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension WeekController:UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}

extension WeekController:WeekCellDelegate {
    func didSelect(button cell: WeekCell, team: String) {
        guard let sw = self.selectedWeek else {return}
        guard let l = self.delegate?.getLeague() else {return}
        guard let tid = self.delegate?.getTeam().id else {return}
        let t = NFLModel.getTeam(teamNumber: team)
        let u = LoginAPI.shared.UID
        let alertM = "Do you want to select \(t.name.replaceAll(of: "\n", with: " ")) in Week \(sw)?"
        let alert = UIAlertController(title: "Make Pick?",
                                      message: alertM,
                                      preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {done in
            PickAPI.makePick(uid: u, lid: l.lid, tid: tid, pick: t.id, pickweek: sw, completion: {completion in
                print(completion)
                DispatchQueue.main.async {
                    self.loadSchedule(week: self.selectedWeek)
                }
            })
        })
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(no)
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
    }
}
