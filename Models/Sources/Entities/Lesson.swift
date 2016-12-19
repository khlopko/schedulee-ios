//
//  Lesson.swift
//  Schedulee
//
//  Created on 8/14/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public struct Lesson: WebEntity {
    
    public let id: Int
    public let title: String
    public let room: String
    public let lector: Lector
    public let dayOfWeek: DayOfWeek
    public let weekNumber: Int
    public let position: Int
    
    public init(_ data: Any?) {
        let json: JSON = parse(data)
        id = parse(json[.id])
        title = parse(json[.title])
        room = parse(json[.room])
        lector = Lector(json[.lector])
        weekNumber = parse(json[.weekNumber])
        position = parse(json[.position])
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
        
        public static let all: [DayOfWeek] = [
            .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday,
        ]
    }
}
