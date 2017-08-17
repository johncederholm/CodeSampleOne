//
//  Serializer.swift
//  Suicide League
//
//  Created by John Cederholm on 8/9/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class Serializer {
    class func serializeDataArray(data:Data?) -> (completion:[[String: Any]]?, error:NSError?) {
        guard let data = data else {
            let error = NSError(domain: "NoData", code: 0, userInfo:nil)
            return (nil, error)
        }
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [[String:Any]] {
                return (json, nil)
            } else if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                return ([json], nil)
            } else {
                return (nil, nil)
            }
        } catch {
            return (nil, nil)
        }
    }
}
