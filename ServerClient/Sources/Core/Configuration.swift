//
//  Configuration.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public protocol Configuration {
    
    associatedtype Value
    
    var map: (Any?) -> (Value) { get }
    var request: Request { get }
}

extension Configuration {
    
    public final var task: Task<Value> {
        return Task(configuration: self)
    }
}
