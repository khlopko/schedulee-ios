//
//  UserSettings.swift
//  Schedulee
//
//  Created on 9/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

final class UserSettings {
    
    static let `default` = UserSettings()
    
    private struct Key {
        static let currentGroupID = "com.schedulee.currentGroupIDKey"
        static let animatedSplash = "com.schedulee.animatedSplashKey"
    }
    
    let isGodMode = true
    var currentGroupID: Int {
        get { return UserDefaults.standard.integer(forKey: Key.currentGroupID) }
        set { UserDefaults.standard.set(newValue, forKey: Key.currentGroupID) }
    }
    var isAnimatedSplash: Bool {
        get { return UserDefaults.standard.bool(forKey: Key.animatedSplash) }
        set { UserDefaults.standard.set(newValue, forKey: Key.animatedSplash) }
    }
}
