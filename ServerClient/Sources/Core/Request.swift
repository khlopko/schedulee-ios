//
//  Request.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/19/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public protocol Request: Cancellable {
    func resume(completion: @escaping (Result<Any>) -> ())
}
