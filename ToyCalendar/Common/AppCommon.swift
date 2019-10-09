//
//  AppCommon.swift
//  ToyCalendar
//
//  Created by sangdon.kim on 2019/10/09.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class AppCommon {
    static let baseURL: String = ""
    static var isDebugLogEnabled: Bool = false
    
    static func dprint(_ str: String) {
        if AppCommon.isDebugLogEnabled {
            NSLog("[TC][DEBUG] \(str)")
        }
    }
    
    static func eprint(_ str: String) {
        NSLog("[TC][Error] \(str)")
    }
}

enum AppKey {
    static let kakaoKey: String = "85011d04aa986971f3126aaa1a6e28e7"
    static let googleClientID: String = "449229266562-g1aupf6bbvkp0tdk3vj7t79o24bmgrjp.apps.googleusercontent.com"
}
