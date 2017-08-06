//
//  SignupController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class SignupController:ShadowController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
        closeButton.addTarget(self, action: #selector(SignupController.closeController(sender:)), for: .touchUpInside)
    }
    
    func closeController(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
