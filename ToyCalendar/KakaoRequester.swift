//
//  KakaoRequester.swift
//  ToyCalendar
//
//  Created by 한상준 on 11/03/2019.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

class KakoRequester{
    static func executeLogin(){
        let session = KOSession.shared()
        if let session = session{
            if session.isOpen(){
                session.close()
            }
            session.open(completionHandler: {(error) in
                if error == nil{
                    if session.isOpen(){
                    }
                }
            })
        }
    }
}
