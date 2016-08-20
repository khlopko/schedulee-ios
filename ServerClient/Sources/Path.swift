//
//  Path.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Models

fileprivate let serverURLString = "http://localhost/api/v1/"

enum Path: String {
    
    case currentLesson = "currentLesson"
    case lectors = "lectors/all"
    case lessons = "lessons/all"
    
    var full: String {
        return serverURLString + rawValue
    }
    
    var temp: JSON {
        switch self {
        case .currentLesson:
            return lessonJSON
        case .lectors:
            return lectorsJSON
        case .lessons:
            return lessonsJSON
        }
    }
}
