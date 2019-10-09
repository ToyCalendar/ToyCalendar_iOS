//
//  UserDefaultsManager.swift
//  ToyCalendar
//
//  Created by sangdon.kim on 2019/10/09.
//  Copyright © 2019 YAPP. All rights reserved.
//

import Foundation

public class UserDefaultsManager {
    public static let LastLoginMethod = AppDefaults<Int>(key: "LastLoginMethod", defaultValue: 4)
}

public class AppDefaults<T>: NSObject {
    private let key: String
    private let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public func get() -> T {
        return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
    }
    
    public func set(_ value: T) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
