//
//  Key.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public enum WebKey: String {
    
    case course = "course"
    case dayOfWeek = "dayOfWeek"
    case firstname = "firstname"
    case groups = "groups"
    case id = "id"
    case info = "info"
    case lastname = "lastname"
    case lector = "lector"
    case lectors = "lectors"
    case lessons = "lessons"
    case position = "position"
    case room = "room"
    case title = "title"
    case type = "type"
    case sorname = "sorname"
    case weekNumber = "weekNumber"
        
    var value: String {
        return rawValue
    }
}

// MARK: - Subscript dictionary

public extension Dictionary where Key: StringKey, Value: Any {
    
    public subscript(_ webKey: WebKey) -> Value? {
        get { return self[webKey.value as! Key] }
        set { self[webKey.value as! Key] = convertValue(newValue) as? Value }
    }
}

private func convertValue(_ value: Any?) -> Any? {
    if let string = value as? String {
        return string
    } else if let double = value as? Double {
        if let int = value as? Int {
            if fabs(double - Double(int)) < 1E-14 {
                return int
            } else {
                return double
            }
        }
    } else if let int = value as? Int {
        return int
    } else if let dict = value as? NSDictionary {
        return dict
    } else if let array = value as? [Any] {
        return array
    } else if let boolean = value as? Bool {
        return boolean
    } else if value != nil {
        fatalError("Unknown object in NSMutableDictionary subscript for WebKey")
    }
    return value
}

// MARK: - Parameters

public struct Parameters: ExpressibleByDictionaryLiteral, RawRepresentable {
    
    public typealias Key = WebKey
    public typealias Value = Any?
    public typealias RawValue = [Key.RawValue: Value]
    
    private var dictionary: [Key: Value]
    
    public var rawValue: RawValue {
        var raw = RawValue()
        for (key, value) in dictionary {
            raw[key.value] = value
        }
        return raw
    }
    
    public init?(rawValue: RawValue) {
        self.init()
        for (rawKey, value) in rawValue {
            if let key = Key(rawValue: rawKey) {
                dictionary[key] = value
            }
        }
    }
    
    public init(dictionaryLiteral items: (WebKey, Value) ...) {
        self.init()
        for item in items {
            dictionary[item.0] = item.1
        }
    }
    
    private init() {
        dictionary = [:]
    }
}
