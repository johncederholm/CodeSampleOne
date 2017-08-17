//
//  AutoCompleteDelegate.swift
//  Suicide League
//
//  Created by John Cederholm on 8/11/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class AutoCompleteDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var items:[String]?
    var onSelect:(String, IndexPath)->() = {_,_ in}
    var searchPrefix:String?
    var usableItems:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekSelectionCell") as! WeekSelectionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usableItems.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if usableItems.indices.contains(indexPath.row) {
            guard let cell = cell as? WeekSelectionCell else {return}
            cell.setCell(name: "John")
//            let textToUse:NSMutableAttributedString = NSMutableAttributedString()
//            let str = usableItems[indexPath.row] as NSString
//            let item = usableItems[indexPath.row]
//            if let searchPrefix = searchPrefix {
//                let boldFont = UIFont(name: textFontBold, size: 15)
//                let fuschia = UIColor.fuschiaColor()
//                let boldAtt = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: fuschia]
//                let regFont = UIFont(name: textFont, size: 13)
//                let regAtt = [NSFontAttributeName: regFont, NSForegroundColorAttributeName: UIColor.black]
//                let range = str.range(of: searchPrefix, options: .caseInsensitive)
//                let attString = NSMutableAttributedString(string: item.capitalized, attributes: regAtt)
//                attString.addAttributes(boldAtt, range: range)
//                textToUse.append(attString)
//            } else {
//                textToUse.append(createTextString(item, size: 14))
//            }
//            cell.label.attributedText = textToUse
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WeekSelectionCell else {return}
        if let selectedText = cell.weekLabel.text {
            onSelect(selectedText, indexPath)
        }
    }
}
