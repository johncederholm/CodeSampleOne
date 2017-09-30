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
    var agreeButton:UIButton?
    var disagreeButton:UIButton?
    var webview:UIWebView?
    
    override func viewDidLoad() {
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 6
        signupButton.addTarget(self, action: #selector(LoginController.goToSignup(sender:)), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(LoginController.submitButtonPressed(sender:)), for: .touchUpInside)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"header")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: UIBarPosition.top, barMetrics: .default)
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear

//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let keychain = KCModel.getInfo()
        if let username = keychain.username,
            let password = keychain.password {
            if username.trimmingCharacters(in: .whitespaces).isEmpty ||
                password.trimmingCharacters(in: .whitespaces).isEmpty {
                return
            }
            usernameField.text = username
            passwordField.text = password
        }
    }
    
    func submitButtonPressed(sender:AnyObject?) {
        loginWithInfo(isDisclaimer: false)
    }
    
    
    func loginWithInfo(isDisclaimer:Bool) {
        guard let password = passwordField.text else {noPassword();return}
        guard let name = usernameField.text else {noUsername();return}
        self.showLoadingScreen()
        LoginAPI.shared.login(username: name, password: password, isDisclaimer: isDisclaimer, completion: {done in
            DispatchQueue.main.sync {
                self.removeLoadingScreen()
                guard let message = done.0 else {self.error(message:nil);return}
                guard let response = done.1 else {self.error(message: nil);return}
                switch response {
                case .success:
                    KCModel.setInfo(username: name, password: password)
                    self.success()
                case .email:
                    self.error(message: message)
                case .needsDisclaimer:
                    self.showDisclaimer(disclaimer:message)
                case .noPassword:
                    self.error(message: "Check your password.")
                case .noUsername:
                    self.error(message: "No username.")
                case .noResponse:
                    self.error(message: "Try again later.")
                }
                return
            }
        })
    }
    
    func showDisclaimer(disclaimer: String) {
        let parent:UIView = self.navigationController?.view != nil ? self.navigationController!.view : self.view
        webview = UIWebView(frame: CGRect(x: 0, y: 0, width: parent.bounds.width, height: parent.bounds.height))
        webview?.loadHTMLString(disclaimer, baseURL: URL(string: prefix + "Disclaimer.php"))
        parent.addSubview(webview!)
        self.view.endEditing(true)
        let offset:CGFloat = 16
        agreeButton = UIButton(frame: CGRect(x: (0.75 * parent.bounds.width) - offset, y: parent.bounds.height - 55, width: parent.bounds.width / 4, height: 45))
        disagreeButton = UIButton(frame: CGRect(x: offset, y: parent.bounds.height - 55, width: parent.bounds.width / 4, height: 45))
        agreeButton?.backgroundColor = UIColor.blue
        disagreeButton?.backgroundColor = UIColor.red
        agreeButton?.setTitle("Agree", for: .normal)
        disagreeButton?.setTitle("Disagree", for: .normal)
        parent.addSubview(agreeButton!)
        parent.addSubview(disagreeButton!)
        parent.bringSubview(toFront: disagreeButton!)
        parent.bringSubview(toFront: agreeButton!)
        agreeButton?.addTarget(self, action: #selector(LoginController.agree), for: .touchUpInside)
        disagreeButton?.addTarget(self, action: #selector(LoginController.disagree), for: .touchUpInside)
    }
    
    func agree() {
        self.removeWebview(isDisclaimer: true)
    }
    
    func disagree() {
        self.removeWebview(isDisclaimer: false)
    }
    
    func removeWebview(isDisclaimer:Bool) {
        let parent:UIView = self.navigationController?.view != nil ? self.navigationController!.view : self.view
        let offset:CGFloat = 16
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut,
                       animations: {
                        self.webview?.frame.origin = CGPoint(x: 0, y: parent.bounds.height)
                        self.disagreeButton?.frame.origin = CGPoint(x: offset, y: parent.bounds.height)
                        self.agreeButton?.frame.origin = CGPoint(x: (0.75 * parent.bounds.width) - offset, y: parent.bounds.height)
        }, completion: {done in
            self.webview?.removeFromSuperview()
            self.agreeButton?.removeFromSuperview()
            self.disagreeButton?.removeFromSuperview()
            self.webview = nil
            self.agreeButton = nil
            self.disagreeButton = nil
            if isDisclaimer == true {
                self.loginWithInfo(isDisclaimer: isDisclaimer)
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
    
    func error(message:String?) {
        let alert = UIAlertController(title: "Error", message: message ?? "Check your info and try again.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToSignup(sender:AnyObject) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupController") as? SignupController {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.delegate = self
        }
    }
    private func getHtmlLabel(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = stringFromHtml(string: text)
        return label
    }
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
}

extension LoginController: SignupDelegate {
    func didSignup(username: String, password: String) {
        usernameField.text = username
        passwordField.text = password
        self.submitButtonPressed(sender: nil)
    }
}
