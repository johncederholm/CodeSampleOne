//
//  LoginController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol LoginControllerDelegate: class {
    func wasLoggedIn(controller:LoginController)
}

class LoginController: ShadowController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var delegate:LoginControllerDelegate?
    
    override func viewDidLoad() {
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
        signupButton.addTarget(self, action: #selector(LoginController.goToSignup(sender:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(LoginController.submitButtonPressed(sender:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let keychain = KCModel.getInfo()
        if let username = keychain.username,
            let password = keychain.password {
            if username.isEmptyOrWhitespace() || password.isEmptyOrWhitespace() {
                return
            }
            usernameField.text = username
            passwordField.text = password
        }
    }
    
    func submitButtonPressed(sender:AnyObject) {
        guard let password = passwordField.text else {noPassword();return}
        guard let name = usernameField.text else {noUsername();return}
        LoginAPI.shared.login(username: name, password: password, completion: {done in
            if done != nil {
                self.success()
                KCModel.setInfo(username: name, password: password)
                return
            } else {
                self.error()
                return
            }
        })
    }
    
    func noPassword() {
        let alert = UIAlertController(title: "No Password", message: "Check your password and try again.", preferredStyle: .alert)
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
        delegate?.wasLoggedIn(controller: self)
        self.dismiss(animated: true, completion: nil)
    }
    
    func error() {
        let alert = UIAlertController(title: "Error", message: "Check your info and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToSignup(sender:AnyObject) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupController") as? SignupController {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
