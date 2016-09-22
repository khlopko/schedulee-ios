//
//  WebEntity.swift
//  Schedulee
//
//  Created on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public typealias JSON = Dictionary<String, Any>

public protocol WebEntity {
    init(_ json: JSON)
}