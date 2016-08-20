//
//  Cancellable.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public protocol Cancellable: class {
    func cancel()
}
