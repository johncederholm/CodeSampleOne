//
//  SignupController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

protocol SignupDelegate:class {
    func didSignup(username:String, password:String)
}

class SignupController:ShadowController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var delegate:SignupDelegate?
    typealias SignupInfo = (username:String?, password:String?)
    var signupInfo = SignupInfo(username: nil, password: nil)
    
    override func viewDidLoad() {
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
        closeButton.addTarget(self, action: #selector(SignupController.closeController(sender:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(SignupController.goToSignup(sender:)), for: .touchUpInside)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    deinit {
        if let username = signupInfo.username, let password = signupInfo.password {
            delegate?.didSignup(username: username, password: password)
        }
    }
    
    func goToSignup(sender:AnyObject) {
        guard let password = passwordField.text else {noPassword();return}
        guard let name = usernameField.text else {noUsername();return}
        guard let email = emailField.text else {noEmail();return}
        self.showLoadingScreen()
        SignupAPI.signup(username: name, password: password, email:email, completion: {done in
            DispatchQueue.main.async {
                self.removeLoadingScreen()
                if done.0 == .success {
                    self.signupInfo = SignupInfo(username: name, password: password)
                    self.success()
                    KCModel.setInfo(username: name, password: password)
                    return
                } else {
                    self.error(message: done.1 ?? "Error")
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
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func error(message:String) {
        let alert = UIAlertController(title: message, message: "Check your info and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func closeController(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
