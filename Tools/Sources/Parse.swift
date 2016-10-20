//
//  Parse.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 10/10/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

// MARK: - Parse function

public func parse<In, Out: Convertible>(_ input: In?) -> Out {
    return Out.cast(input)
}

// MARK: - Convertible

public protocol Convertible {
    static func cast<T>(_ input: T) -> Self
}

extension String: Convertible {
    
    public static func cast<T>(_ input: T) -> String {
        switch input {
        case let str as String:
            return str
        case let conv as CustomStringConvertible:
            return conv.description
        default:
            return ""
        }
    }
}

extension Int: Convertible {
    
    public static func cast<T>(_ input: T) -> Int {
        return input as? Int ?? 0
    }
}

extension Double: Convertible {
    
    public static func cast<T>(_ input: T) -> Double {
        return input as? Double ?? 0
    }
}

extension Array: Convertible {
    
    public static func cast<T>(_ input: T) -> Array {
        return input as? [Element] ?? []
    }
}

extension Bool: Convertible {
    
    public static func cast<T>(_ input: T) -> Bool {
        return input as? Bool ?? false
    }
}

extension Dictionary: Convertible {
    
    public static func cast<T>(_ input: T) -> Dictionary {
        return input as? Dictionary ?? [:]
    }
}