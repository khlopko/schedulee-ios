//
//  Lesson.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Tools

public struct Lesson: WebEntity {
    
    public let id: String
    public let title: String
    public let room: String
    public let lector: Lector
    public let start: Date
    public let end: Date
    
    public init(_ json: JSON?) {
        id = parse(json?[.id])
        title = parse(json?[.title])
        room = parse(json?[.room])
        lector = Lector(json?[.lector] as? JSON)
        start = Date(timeIntervalSince1970: parse(json?[.startTimestamp]))
        end = Date(timeIntervalSince1970: parse(json?[.endTimestamp]))
    }
}
