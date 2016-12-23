//
//  Task.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public final class Task<Value>: Cancellable {
    
    public typealias Success = (Value) -> ()
    public typealias Failure = (Error) -> ()
    
    private let map: (Any?) -> Value

    private var request: Request?
    private var success: Success?
    private var failure: Failure?
    
    init<C: Configuration>(configuration: C) where C.Value == Value {
        request = configuration.request
        map = configuration.map
    }
    
    public func resume(success: @escaping Success, failure: @escaping Failure) {
        self.success = success
        self.failure = failure
        request?.resume(completion: handleResult)
    }
    
    public func cancel() {
        request?.cancel()
    }
    
    private func handleResult(_ result: Result<Any>) {
        switch result => map {
        case .success(let value):
            success?(value)
        case .failure(let error):
            failure?(error)
        }
        finishRequest()
    }
    
    private func finishRequest() {
        request = nil
        success = nil
        failure = nil
    }
}
