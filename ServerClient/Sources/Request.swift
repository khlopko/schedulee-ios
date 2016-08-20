//
//  Request.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models
import Tools

// MARK: - Request

final class Request<Value>: BaseRequest {
    
    var success: (Value) -> () = { _ in }
    var failure: (NSError) -> () = { _ in }
    var completion: (Request) -> () = { _ in }
    
    typealias ParseClosure = @escaping (JSON) -> (Value)
    let parse: ParseClosure
    
    init(path: Path, parse: ParseClosure) {
        self.parse = parse
        super.init(path: path)
    }
    
    func execute() {
        handleResult(Result.success(path.temp))
    }
}

// MARK: - Cancellable

extension Request: Cancellable {
    
    func cancel() {
    }
}

private extension Request {
    
    func handleResult(_ result: Result<JSON>) {
        switch result => parse {
        case .success(let value):
            handleSuccess(value)
        case .failure(let error):
            handleError(error)
        }
        completion(self)
    }
    
    func handleSuccess(_ value: Value) {
        success(value)
    }
    
    func handleError(_ error: NSError) {
        failure(error)
    }
}
