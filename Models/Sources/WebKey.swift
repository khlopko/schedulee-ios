//
//  Key.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public enum WebKey: String {
    
    case title = "title"
    case startTimestamp = "startTimestamp"
    case endTimestamp = "endTimestamp"
    case lector = "lector"
    case id = "id"
    case fullname = "fullname"
    case room = "room"
    
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
