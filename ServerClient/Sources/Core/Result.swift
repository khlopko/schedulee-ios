//
//  Result.swift
//  WebLibrary
//
//  Created by Kirill Khlopko on 10/6/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public enum Result<Value> {

    case success(Value)
    case failure(Error)
    
    public var data: Value? {
        switch self {
        case let .success(value):
            return value
        case .failure(_):
            return nil
        }
    }
    public var error: Error? {
        switch self {
        case .success(_):
            return nil
        case let .failure(error):
            return error
        }
    }
    public var isSuccess: Bool {
        if case .success(_) = self {
            return true
        }
        return false
    }
    public var isFailure: Bool {
        return !isSuccess
    }
}

// MARK: - Map operator

precedencegroup Map {
    associativity: left
}

infix operator => : Map

public func => <In, Out>(result: Result<In>, closure: (In) -> (Out)) -> Result<Out> {
    switch result {
    case .success(let value):
        return .success(closure(value))
    case .failure(let error):
        return .failure(error)
    }
}
