//
//  UserSettings.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 9/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

final class UserSettings {
    
    static let `default` = UserSettings()
    
    private struct Key {
        static let currentGroupID = "com.schedulee.currentGroupIDKey"
    }
    
    var currentGroupID: Int {
        get { return UserDefaults.standard.integer(forKey: Key.currentGroupID) }
        set { UserDefaults.standard.set(newValue, forKey: Key.currentGroupID) }
    }
}
