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

enum RequestError: Error {
    case badResponse
    case undefined
}

// MARK: - Request

final class Request<Value>: BaseRequest {
    
    var success: (Value) -> () = { _ in }
    var failure: (Error) -> () = { _ in }
    var completion: (Request) -> () = { _ in }
    
    typealias ParseClosure = @escaping (JSON) -> (Value)
    let parse: ParseClosure
    
    fileprivate var task: URLSessionTask?
    
    init(path: Path, parse: ParseClosure) {
        self.parse = parse
        super.init(path: path)
        guard let url = URL(string: path.full) else { fatalError("Not convertible to URL!") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        task = BaseRequest.session.dataTask(with: request) { [weak self] data, response, error in
            let result: Result<JSON>
            if let data = data {
                do {
                    let object = try JSONSerialization.jsonObject(
                        with: data, options: [.mutableContainers, .allowFragments])
                    if let json = object as? JSON {
                        result = Result.success(json)
                    } else {
                        result = Result.failure(RequestError.badResponse)
                    }
                } catch {
                    result = Result.failure(error)
                }
            } else {
                let error = error ?? RequestError.undefined
                result = Result.failure(error)
            }
            self?.handleResult(result)
        }
    }
    
    func execute() {
        task?.resume()
    }
}

// MARK: - Cancellable

extension Request: Cancellable {
    
    func cancel() {
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
