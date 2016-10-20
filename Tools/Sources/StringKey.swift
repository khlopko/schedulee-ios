//
//  StringKey.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 10/10/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

// MARK: - Protocol StringKey

public protocol StringKey {
    
    var value: String { get }
}

extension String: StringKey {
    
    public var value: String {
        return self
    }
}
