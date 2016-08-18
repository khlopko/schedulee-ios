//
//  Global.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/13/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

infix operator ->> { associativity left precedence 105 }

public func ->> <T>(_ object: T, _ closure: @noescape (T) -> ()) -> T {
    closure(object)
    return object
}
