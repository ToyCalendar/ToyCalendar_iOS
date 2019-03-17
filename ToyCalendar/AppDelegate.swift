//
//  AppDelegate.swift
//  ToyCalendar
//
//  Created by sdondon on 23/12/2018.
//  Copyright © 2018 YAPP. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
import LineSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Facebook SignIn
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //initialize google signin
        GIDSignIn.sharedInstance().clientID = "1022792460718-opii1d382k35ro0a7ds7o1d0l95mpe1m.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        //Line
        LoginManager.shared.setup(channelID: "1553598702", universalLinkURL: nil)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        //kakao
        
        if KOSession.isKakaoAccountLoginCallback(url) {
            
            return KOSession.handleOpen(url)
        }
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)
        
        let facebookDidhandle = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return googleDidHandle || facebookDidhandle
    }
    
    func application(application: UIApplication, handleOpenURL url: URL) -> Bool {
        
        //kakao
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    //iOS 10 이상을 사용하는 경우 다음 코드를 사용하여 위 샘플의 마지막 호출을 변경할 수 있습니다. 이렇게 하면 더욱 다양한 옵션을 사용할 수 있습니다.
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let googleDidHandle = GIDSignIn.sharedInstance().handle(url as URL?,
                                                                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                                annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        let facebookDidhandle = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        let lineDidhandle = LoginManager.shared.application(app, open: url, options: options)
        return googleDidHandle || facebookDidhandle || lineDidhandle
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


extension AppDelegate: GIDSignInDelegate{
    
    //GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
