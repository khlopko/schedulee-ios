//
//  ServerClient.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models

open class ServerClient {
    
    public static let instance = ServerClient()
    
    public typealias Success<T> = (T) -> ()
    public typealias Failure = (Error) -> ()
    
    private var requests = Set<BaseRequest>()
    
    private init() {
    }
    
    func addRequest<T>(_ request: Request<T>) {
        requests.insert(request)
        request.completion = { self.requests.remove($0) }
        request.execute()
    }
}

public extension ServerClient {
    
    func loadLectors(success: Success<[Lector]>, failure: Failure) {
        /*let request = Request(path: .lectors, parse: { [Lector](webkey: .lectors, json: $0) })
        request.success = success
        request.failure = failure
        addRequest(request)*/
    }
    
    func loadLessons(on date: Date, success: Success<[Lesson]>, failure: Failure) {
        let request = Request(path: .lessons(group: 301), parse: { [Lesson](webkey: .lessons, json: $0) })
        request.success = success
        request.failure = failure
        addRequest(request)
    }
}
