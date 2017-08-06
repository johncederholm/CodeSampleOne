//
//  LoginController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class LoginController: ShadowController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
        signupButton.addTarget(self, action: #selector(LoginController.goToSignup(sender:)), for: .touchUpInside)
    }
    

    func goToSignup(sender:AnyObject) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupController") {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
