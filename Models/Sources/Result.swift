//
//  Result.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

// MARK: - Result

public enum Result<Data> {
    
    case success(Data)
    case failure(NSError)
}

// MARK: - Map operator

infix operator => { associativity left precedence 110 }

public func => <In, Out>(result: Result<In>, closure: (In) -> (Out)) -> Result<Out> {
    switch result {
    case .success(let data):
        return Result<Out>.success(closure(data))
    case .failure(let error):
        return Result<Out>.failure(error)
    }
}
