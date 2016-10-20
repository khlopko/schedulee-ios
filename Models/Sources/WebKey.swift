//
//  Key.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public enum WebKey: String {
    
    case dayOfWeek = "dayOfWeek"
    case firstname = "firstname"
    case groups = "groups"
    case id = "id"
    case lastname = "lastname"
    case lector = "lector"
    case lectors = "lectors"
    case lessons = "lessons"
    case position = "position"
    case room = "room"
    case title = "title"
    case sorname = "sorname"
    case weekNumber = "weekNumber"
        
    var value: String {
        return rawValue
    }
}

// MARK: - Subscript dictionary

public extension Dictionary where Key: StringKey, Value: Any {
    
    subscript(webKey: WebKey) -> Value? {
        return self[webKey.value as! Key]
    }
}
