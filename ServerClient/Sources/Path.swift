//
//  Path.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models

fileprivate let serverURLString = "http://localhost:5000/api/v0.1/"

enum Path {
    
    case lessons(group: Int)
    case groups
    
    var full: String {
        return serverURLString + route
    }
    
    private var route: String {
        switch self {
        case .lessons(let group):
            return "groups/\(group)"
        case .groups:
            return "groups"
        }
    }
}
