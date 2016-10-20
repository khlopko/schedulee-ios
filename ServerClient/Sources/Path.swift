//
//  Path.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models

private let serverURLString = "http://localhost:5000/api/"

enum Path {
    
    case groups
    case lectors
    case lector(id: Int)
    case lessons(groupId: Int)
    
    var full: String {
        return serverURLString + route
    }
    
    private var route: String {
        switch self {
        case .groups:
            return "groups"
        case .lectors:
            return "lectors"
        case let .lector(id):
            return "lectors/\(id)"
        case let .lessons(groupId):
            return "groups/\(groupId)/lessons"
        }
    }
}
