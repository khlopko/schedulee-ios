//
//  Key.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public enum WebKey: String {
    
    case endTimestamp = "endTimestamp"
    case firstname = "firstname"
    case id = "id"
    case lastname = "lastname"
    case lector = "lector"
    case lectors = "lectors"
    case lessons = "lessons"
    case room = "room"
    case title = "title"
    case startTimestamp = "startTimestamp"
    case sorname = "sorname"
        
    var value: String {
        return rawValue
    }
}

protocol StringKey {
}

extension String: StringKey {
}

extension Dictionary where Key: StringKey, Value: AnyObject {
    
    subscript(webKey: WebKey) -> Value? {
        return self[webKey.value as! Key]
    }
}
