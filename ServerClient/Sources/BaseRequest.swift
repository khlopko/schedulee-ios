//
//  BaseRequest.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

class BaseRequest {
    
    static let session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    let path: Path
    
    init(path: Path) {
        self.path = path
    }
}

// MARK: - Hashable

extension BaseRequest: Hashable {
    
    var hashValue: Int {
        return path.full.hashValue
    }
}

// MARK: - Equatable

extension BaseRequest: Equatable {
}

func ==(lhs: BaseRequest, rhs: BaseRequest) -> Bool {
    return lhs === rhs
}
