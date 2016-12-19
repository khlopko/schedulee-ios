//
//  Result.swift
//  WebLibrary
//
//  Created by Kirill Khlopko on 10/6/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public enum Result<Data> {

    case success(Data)
    case failure(Error)
    
    public var data: Data? {
        switch self {
        case let .success(data):
            return data
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
    case .success(let data):
        return Result<Out>.success(closure(data))
    case .failure(let error):
        return Result<Out>.failure(error)
    }
}
