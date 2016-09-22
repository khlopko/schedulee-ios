//
//  ServerClient.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Models
import Tools

public final class ServerClient {
    
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
    
    @discardableResult
    func loadLectors(success: @escaping Success<[Lector]>, failure: @escaping Failure) -> Cancellable {
        let request = Request(path: .lectors, parse: { [Lector](webkey: .lectors, json: $0) })
        request.success = success
        request.failure = failure
        addRequest(request)
        return request
    }
    
    @discardableResult
    func loadLessons(groupId: Int, success: @escaping Success<[Lesson]>, failure: @escaping Failure) -> Cancellable {
        let request = Request(path: .lessons(groupId: groupId), parse: { [Lesson](webkey: .lessons, json: $0) })
        request.success = success
        request.failure = failure
        addRequest(request)
        return request
    }
    
    @discardableResult
    func loadGroups(success: @escaping Success<[Group]>, failure: @escaping Failure) -> Cancellable {
        let request = Request(path: .groups, parse: { [Group](webkey: .groups, json: $0) })
        request.success = success
        request.failure = failure
        addRequest(request)
        return request
    }
}
