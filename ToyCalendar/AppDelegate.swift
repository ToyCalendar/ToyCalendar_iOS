//
//  AppDelegate.swift
//  ToyCalendar
//
//  Created by sdondon on 23/12/2018.
//  Copyright © 2018 YAPP. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance()?.clientID = AppKey.googleClientID
        GIDSignIn.sharedInstance()?.delegate = TCLoginManager.shared
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        AppCommon.isDebugLogEnabled = true
//        _ = RWLoginManager.shared
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        } else if GIDSignIn.sharedInstance()?.handle(url, sourceApplication: sourceApplication, annotation: annotation) ?? false {
            return true
        } else {
            return false
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        } else if ApplicationDelegate.shared.application(app, open: url, options: options) {
            return true
        } else if GIDSignIn.sharedInstance()?.handle(url, sourceApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue, annotation: options[UIApplication.OpenURLOptionsKey.annotation]) ?? false {
            return true
        } else {
            return false
        }
    }
}

