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
    public let duration: TimeInterval
    
    public init(_ json: JSON?) {
        id = parse(json?[.id])
        title = parse(json?[.title])
        room = parse(json?[.room])
        let lectorJSON: JSON = parse(json?[.lector])
        lector = Lector(lectorJSON)
        start = Date(timeIntervalSince1970: parse(json?[.startTimestamp]))
        end = Date(timeIntervalSince1970: parse(json?[.endTimestamp]))
        duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
    }
}

public extension Lesson {
    
    var pastPercents: Double {
        let nowTimestamp = Date().timeIntervalSince1970
        let past = nowTimestamp - start.timeIntervalSince1970
        let percents = past / duration
        return percents
    }
    var isCurrent: Bool {
        let now = Date().timeIntervalSince1970
        let result = (start.timeIntervalSince1970...end.timeIntervalSince1970).contains(now)
        return result
    }
}
