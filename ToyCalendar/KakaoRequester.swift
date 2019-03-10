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
        if let s = session{
            if s.isOpen(){
                s.close()
            }
            s.open(completionHandler: {(error) in
                if error == nil{
                    print("No error")
                    if s.isOpen(){
                        print("Success")
                    }
                    else{
                        print("Fail")
                    }
                }
                else{
                    print("Error login: \(error!)")
                }
            })
        }else{
            print("Seesion error")
        }
    }
}
