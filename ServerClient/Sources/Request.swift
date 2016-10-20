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

final class Request<Value>: BaseRequest, Cancellable {
    
    typealias ParseClosure = (JSON) -> (Value)
    let parse: ParseClosure
    
    var method: Method = .get
    
    var success: (Value) -> () = { _ in }
    var failure: (Error) -> () = { _ in }
    var completion: (Request) -> () = { _ in }
    
    private let request: DataRequest
    
    init(path: Path, parse: @escaping ParseClosure) {
        self.parse = parse
        request = DataRequest(urlString: path.full)
        super.init(path: path)
        request.resultClosure = { [weak self] in
            self?.handleResult($0)
        }
    }
    
    func execute() {
        request.resume()
    }
    
    public func cancel() {
        request.cancel()
    }
    
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
    
    func handleError(_ error: Error) {
        failure(error)
    }
}
