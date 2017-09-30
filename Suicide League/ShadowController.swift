//
//  ShadowController.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import Foundation
import UIKit

class ShadowController:UIViewController {
    var loadingScreen:UIView!
    var shadowView:UIView!
    var shadowSize:CGFloat {
        get {
            return self.view.bounds.width / 5
        }
    }
    var shadowCenter:CGPoint {
        get {
            return self.view.center
        }
    }
    
    override func viewWillLayoutSubviews() {
        applyShadows()
    }
    
    func applyShadows() {
        if (shadowView != nil) {return}
        shadowView = UIView()
        shadowView.frame.size = CGSize(width: shadowSize, height: shadowSize)
        shadowView.center = shadowCenter
        self.view.addSubview(shadowView)
        self.view.sendSubview(toBack: shadowView)
        applyShadow(shadowView: shadowView)
    }
    
    func applyShadow(shadowView: UIView) {
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.white.cgColor
        shadowView.layer.shadowRadius = 50
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize.zero
        let x = shadowView.bounds.origin.x
        let y = shadowView.bounds.origin.y
        let width = shadowView.bounds.width
        let height = shadowView.bounds.height
        shadowView.layer.shadowPath = CGPath(rect: CGRect(x: x, y: y, width: width, height: height), transform: nil)
    }
    
    func showLoadingScreen() {
        if loadingScreen != nil {return}
        let useBounds = self.navigationController?.view.bounds ?? self.view.bounds
        let width = useBounds.width
        loadingScreen = UIView()
        loadingScreen.frame = useBounds
        loadingScreen.backgroundColor = UIColor.clear
        let backgroundView = UIView()
        backgroundView.frame.size = CGSize(width: width / 3, height: width / 3)
        backgroundView.center = CGPoint(x: width / 2, y: width / 2)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        let loadingView = NVActivityIndicatorView(frame: backgroundView.bounds,
                                                  type: .ballClipRotateMultiple,
                                                  color: UIColor.white,
                                                  padding: backgroundView.bounds.width / 6)
        loadingView.startAnimating()
        (self.navigationController?.view ?? self.view).addSubview(loadingScreen)
        loadingScreen.addSubview(backgroundView)
        backgroundView.addSubview(loadingView)
    }
    
    func removeLoadingScreen() {
        if loadingScreen == nil {return}
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseIn, .curveEaseOut], animations: {
            for view in self.loadingScreen.subviews {
                view.alpha = 0
            }
            self.view.layoutIfNeeded()
        }, completion: {done in
            self.loadingScreen?.removeFromSuperview()
            self.loadingScreen = nil
        })
    }
}
