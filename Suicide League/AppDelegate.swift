//
//  AppDelegate.swift
//  Suicide League
//
//  Created by John Cederholm on 7/29/17.
//  Copyright © 2017 d2i LLC. All rights reserved.
//

import UIKit

var textFontBold:String = "Helvetica"
var textFont:String = "Helvetica"
var buttonBold:String = "Helvetica"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().toolbarManageBehaviour = IQAutoToolbarManageBehaviour.byTag
        
        let url:URL = URL(string: "http://suicideleague.com/v6/stub/Login.php")!
        var request:URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = "username=johncederholm@gmail.com&password=johncederholm&remember_me=false"
        request.httpBody = bodyData.data(using: .utf8)
//        request.addValue("no-cache, must-revalidate", forHTTPHeaderField: "Cache-Control")
//        request.addValue("Mon, 26 Jul 1997 05:00:00 GMT", forHTTPHeaderField: "Expires")
        NSURLConnection.sendAsynchronousRequest(request, queue: .main, completionHandler: {response, data, error in
//            print(response)
//            print(data)
//            print(error)
//            let st = String(data: data!, encoding: String.Encoding.utf8)
//            st
//            print(String(data: data!, encoding: String.Encoding.utf8))
        })
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

