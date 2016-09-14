//
//  Global.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

/// Operator that helps to setup object properies after creating object.
/// - parameter object: Object to specify.
/// - parameter closure: Closure with operations to apply.
/// - returns: Object after applying changes in closure.
public func ->> <T>(_ object: T, _ closure: @noescape (T) -> ()) -> T {
    closure(object)
    return object
}

infix operator ->> { associativity left precedence 105 }
