//
//  OptionsController.swift
//  Suicide League
//
//  Created by John Cederholm on 8/14/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol OptionsDelegate:class {
    func didLogout()
}

class OptionsController:ShadowController {
    @IBOutlet weak var logoutButton: UIButton!
    var delegate:OptionsDelegate?

    override func viewDidLoad() {
        logoutButton.addTarget(self, action: #selector(OptionsController.logout), for: .touchUpInside)
    }
    
    func logout() {
        LoginAPI.shared.logout(completion: {done in
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
    }
}
