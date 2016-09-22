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
    
    typealias ParseClosure = (JSON) -> (Value)
    let parse: ParseClosure
    
    var method: Method = .get
    
    var success: (Value) -> () = { _ in }
    var failure: (Error) -> () = { _ in }
    var completion: (Request) -> () = { _ in }
    
    var request: URLRequest? { return task?.originalRequest }
    var response: HTTPURLResponse? { return task?.response as? HTTPURLResponse }
    fileprivate(set) var task: URLSessionTask?
    
    init(path: Path, parse: @escaping ParseClosure) {
        self.parse = parse
        super.init(path: path)
        guard let url = URL(string: path.full) else { fatalError("Not convertible to URL!") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        task = BaseRequest.session.dataTask(with: request) { [weak self] data, response, error in
            self?.jsonResult(data: data, error: error, completion: { result in
                DispatchQueue.main.async {
                    self?.handleResult(result)
                }
            })
        }
    }
    
    func execute() {
        task?.resume()
    }
}

// MARK: - Cancellable

extension Request: Cancellable {
    
    public func cancel() {
        task?.cancel()
        task = nil
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
    
    func handleError(_ error: Error) {
        failure(error)
    }
}
