//
//  Parse.swift
//

import Foundation

///
/// Static-typed parsing of json values.
///
/// This function helps to parse value from json to any type of property, that implements `Convertible` protocol.
/// Types to be parsed easy to add and manage.
///
/// - parameter input: Some type to be parsed from.
///
/// - returns: Parsed value according to specified `Out` type.
///
public func parse<In, Out: Convertible>(_ input: In?) -> Out {
    return Out.cast(input)
}

///
/// Static-typed parsing of json array.
///
/// - parameter input: Some type to be parsed from.
/// - parameter map: Transformation closure that will be applyied to all elements in array. Return type is same to `Element` of array.
///
/// - returns: Parsed value according to specified `Out` type.
///
public func parse<Out>(_ input: Any?, _ map: (Any) -> (Out)) -> [Out] {
    let array: [Any] = parse(input)
    let result = array.map(map)
    return result
}

///
/// Parses a chain of included dictionaries and returns typed result.
///
/// This is experimantal implementation, not tested enoght.
///
/// - parameter input: Some json to be parsed from.
/// - parameter keys: List of keys for inner structures. Can contain any count of keys.
///
/// - returns: Parsed value according to specified `Out` type.
///
public func parseChain<Out: Convertible>(_ input: JSON, keys: String ...) -> Out {
    return parse(keys.reduce(input) { result, key in parse(result[key]) })
}

///
/// Convertible protocol.
///
public protocol Convertible {
    
    ///
    /// Static method that incapsulates casting logic to concrete type.
    ///
    /// Even if casting failed, in implementation should be returned default value.
    ///
    /// - parameter input: Some type to be parsed from.
    /// 
    /// - returns: Instance of class, that implements that protocol.
    ///
    static func cast<T>(_ input: T) -> Self
}

/// Here is some default implementations for basic types. You can change it as you need to.

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
        if let int = input as? Int {
            return int
        }
        return 0
    }
}

extension Int64: Convertible {
    
    public static func cast<T>(_ input: T) -> Int64 {
        switch input {
        case let int as Int:
            return Int64(int)
        case let int64 as Int64:
            return int64
        default:
            return 0
        }
    }
}

extension Double: Convertible {
    
    public static func cast<T>(_ input: T) -> Double {
        if let double = input as? Double {
            return double
        }
        return 0.0
    }
}

extension Array: Convertible {
    
    public static func cast<T>(_ input: T) -> Array {
        if let array = input as? [Element] {
            return array
        }
        return []
    }
}

extension Bool: Convertible {
    
    public static func cast<T>(_ input: T) -> Bool {
        if let boolean = input as? Bool {
            return boolean
        }
        return false
    }
}

extension Dictionary: Convertible {
    
    public static func cast<T>(_ input: T) -> Dictionary {
        if let dict = input as? Dictionary {
            return dict
        }
        return [:]
    }
}
