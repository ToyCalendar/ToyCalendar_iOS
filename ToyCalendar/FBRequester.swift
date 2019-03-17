//
//  FBRequester.swift
//  ToyCalendar
//
//  Created by 한상준 on 10/03/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class FBRequester {
    static func executeLogin(_ loginViewController: LoginViewController) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: loginViewController)
        { (result, err) in
            if err != nil{
                print("Custom FB Login falied : ")
                return
            }
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start(completionHandler: {(connection , result, err) in
                
                if err != nil{
                    print("Failed to start graph request:")
                    return
                }
                guard let dic = result as? NSDictionary,
                    let _ = dic["email"] as? String,
                    let _ = dic["name"] as? String,
                    let _ = dic["id"]  as? String
                    else { return }
                print("facebook token")
                print(FBSDKAccessToken.current().tokenString)
                
                
                
            })
        }
    }
}
