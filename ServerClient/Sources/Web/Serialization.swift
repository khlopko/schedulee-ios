//
//  Serialization.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 9/22/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Models
import Tools

enum SerializationError: Error {
    case dataEmptyOrNil
    case undefined
}

protocol ResponseSerializerProtocol {
    associatedtype Serialized
    var serialize: (HTTPURLResponse?, Data?, Error?) -> Result<Serialized> { get }
}

struct ResponseSerializer<Value>: ResponseSerializerProtocol {
    
    typealias Serialized = Value
    
    var serialize: (HTTPURLResponse?, Data?, Error?) -> Result<Value>
    
    init(_ serialize: @escaping (HTTPURLResponse?, Data?, Error?) -> (Result<Value>)) {
        self.serialize = serialize
    }
}

extension DataRequest {
    
    func jsonResult(data: Data?, error: Error?, completion: (Result<Any>) -> ()) {
        let serializer = ResponseSerializer<Any> { response, data, error in
            if let error = error {
                return Result.failure(error)
            }
            guard let data = data else { return Result.failure(SerializationError.dataEmptyOrNil) }
            do {
                let object = try JSONSerialization
                    .jsonObject(with: data, options: [.mutableContainers, .allowFragments])
                return Result.success(object)
            } catch let excpError {
                return Result.failure(excpError)
            }
        }
        let result = serializer.serialize(response, data, error)
        completion(result)
    }
}
