//
//  ServerClient.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Models
import Tools

// MARK: - WebConfiguration

public protocol WebConfiguration: Configuration {
    var path: Path { get }
}

extension WebConfiguration {
    
    public final var request: Request {
        return DataRequest(urlString: path.full)
    }
}

// MARK: - GroupsConfiguration

public final class GroupsConfiguration: WebConfiguration {
    
    public let path: Path = .groups
    public let map: (Any?) -> [Group] = { data in
        let json: JSON = parse(data)
        return parse(json[.groups], Group.init)
    }
    
    public init() {
    }
}

// MARK: - LectorsConfiguration

public final class LectorsConfiguration: WebConfiguration {
    
    public let path: Path = .lectors
    public let map: (Any?) -> [Lector] = { data in
        let json: JSON = parse(data)
        return parse(json[.lectors], Lector.init)
    }
    
    public init() {
    }
}

// MARK: - LessonsConfiguration

public final class LessonsConfiguration: WebConfiguration {
    
    public let path: Path
    public let map: (Any?) -> [Lesson] = { data in
        let json: JSON = parse(data)
        let containers: [Container] = parse(json[.lessons], Container.init)
        return containers.flatMap { $0.makeLessons() }
    }
    
    public init(groupID: Int) {
        path = .lessons(groupID: groupID)
    }
    
    private struct Container {
        let id: Int
        let lector: Any?
        let title: String
        let info: [JSON]
        
        init(_ data: Any?) {
            let json: JSON = parse(data)
            id = parse(json[.id])
            lector = json[.lector]
            title = parse(json[.title])
            info = parse(json[.info])
        }
        
        func makeLessons() -> [Lesson] {
            let serialized: [JSON] = info.map { json in
                let parameters: Parameters = [
                    .id: id,
                    .title: title,
                    .lector: lector,
                    .room: json[.room],
                    .dayOfWeek: json[.dayOfWeek],
                    .weekNumber: json[.weekNumber],
                    .position: json[.position],
                    .type: json[.type]
                ]
                return parameters.rawValue
            }
            return serialized.map(Lesson.init)
        }
    }
}
