//
//  LoginViewController.swift
//  ToyCalendar
//
//  Created by 한상준 on 27/02/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import LineSDK
class LoginViewController: UIViewController{
    
    
    
    

    @IBAction func kakaoLoginBtn(_ sender: Any) {
        KakoRequester.executeLogin()
    }
    
    @IBAction func lineLoginBtn(_ sender: Any) {
        LineRequester.executeLogin(self)
    }
    
    @IBAction func facebookLoginBtn(_ sender: Any) {
        FBRequester.executeLogin(self)
    }
    
    @IBAction func googleLoginBtn(_ sender: Any) {
//        GIDSignIn.sharedInstance().delegate=self
//        GIDSignIn.sharedInstance().uiDelegate=self as! GIDSignInUIDelegate
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
   

    
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate{
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //        UIActivityIndicatorView.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
}
