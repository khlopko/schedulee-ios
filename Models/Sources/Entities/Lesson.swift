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
    
    public let id: Int
    public let title: String
    public let room: String
    public let lector: Lector
    public let start: Date
    public let end: Date
    public let duration: TimeInterval
    public let dayOfWeek: DayOfWeek
    
    public init(_ json: JSON) {
        id = parse(json[.id])
        title = parse(json[.title])
        room = parse(json[.room])
        lector = Lector(parse(json[.lector]))
        start = Date(timeIntervalSince1970: parse(json[.startTimestamp]))
        end = Date(timeIntervalSince1970: parse(json[.endTimestamp]))
        duration = end.timeIntervalSince1970 - start.timeIntervalSince1970
        guard let dayOfWeek = DayOfWeek(rawValue: parse(json[.dayOfWeek])) else {
            fatalError("Field day of week is empty!")
        }
        self.dayOfWeek = dayOfWeek
    }
}

public extension Lesson {
    
    enum DayOfWeek: Int {
        
        case monday = 0
        case tuesday = 1
        case wednesday = 2
        case thursday = 3
        case friday = 4
        case saturday = 5
        case sunday = 6
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
