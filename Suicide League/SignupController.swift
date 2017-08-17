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
        submitButton.addTarget(self, action: #selector(SignupController.goToSignup(sender:)), for: .touchUpInside)
    }
    
    func goToSignup(sender:AnyObject) {
        guard let password = passwordField.text else {noPassword();return}
        guard let name = usernameField.text else {noUsername();return}
        guard let email = emailField.text else {noEmail();return}
        SignupAPI.signup(username: name, password: password, email:email, completion: {done in
            DispatchQueue.main.async {
                if done == "Success" {
                    self.success()
                    KCModel.setInfo(username: name, password: password)
                    return
                } else {
                    self.error(message: done ?? "Error")
                    return
                }
            }
        })
    }
    
    func noPassword() {
        let alert = UIAlertController(title: "No Password", message: "Check your password and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noEmail() {
        let alert = UIAlertController(title: "No Email", message: "Check your email and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noUsername() {
        let alert = UIAlertController(title: "No Username", message: "Check your username and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func success() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func error(message:String) {
        let alert = UIAlertController(title: message, message: "Check your info and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func closeController(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
