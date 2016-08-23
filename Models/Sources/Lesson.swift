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
    
    public init(_ json: JSON) {
        id = parse(json[.id])
        title = parse(json[.title])
        room = parse(json[.room])
        lector = Lector(parse(json[.lector]))
        start = Date(timeIntervalSince1970: parse(json[.startTimestamp]))
        end = Date(timeIntervalSince1970: parse(json[.endTimestamp]))
        duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
    }
}

public extension Lesson {
    
    var pastPercents: Double {
        let nowTimestamp = Date().timeIntervalSince1970
        let past = nowTimestamp - start.timeIntervalSince1970
        let percents = past / duration
        let r = Double(arc4random() % 100) / 100.0
        return r
    }
    var isCurrent: Bool {
        let now = Date().timeIntervalSince1970
        let result = (start.timeIntervalSince1970...end.timeIntervalSince1970).contains(now)
        let r = (arc4random() % 7)
        let b = hasCurrent ? false : r == 1
        if !hasCurrent {
            hasCurrent = r == 1
        }
        return b
    }
}

private var hasCurrent = false
