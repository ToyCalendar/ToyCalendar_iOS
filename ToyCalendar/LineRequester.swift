//
//  LineRequester.swift
//  ToyCalendar
//
//  Created by 한상준 on 12/03/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation
import LineSDK

class LineRequester {
    static func executeLogin(_ loginViewController: LoginViewController){
        LoginManager.shared.login(permissions: [.profile], in: loginViewController) {
            result in
            switch result {
            case .success(let loginResult):
                print(loginResult.accessToken.value)
            // Do other things you need with the login result
            case .failure(let error):
                print(error)
            }
        }
    }
}
