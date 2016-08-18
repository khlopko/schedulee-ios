//
//  ServerClient.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models

public final class ServerClient {
    
    public static let instance = ServerClient()
    
    public typealias Completion<T> = (Result<T>) -> ()
    public typealias ResponseResult = Result<JSON>
    
    private init() {
    }
}

public extension ServerClient {
    
    func getLesson(_ completion: Completion<Lesson>) {
        imitateResponse {
            let result = ResponseResult.success(lessonJSON) => Lesson.init
            completion(result)
        }
    }
}
