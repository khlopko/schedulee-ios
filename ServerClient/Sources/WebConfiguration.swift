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

// MARK: - LectorsConfiguration

public final class LectorsConfiguration: WebConfiguration {
    
    public let path: Path = .lectors
    public let map: (Any?) -> [Lector]
    
    public init() {
        map = { data in
            let json: JSON = parse(data)
            return parse(json[.lectors], Lector.init)
        }
    }
}

// MARK: - LessonsConfiguration

public final class LessonsConfiguration: WebConfiguration {
    
    public let path: Path
    public let map: (Any?) -> [Lesson]
    
    public init(groupID: Int) {
        path = .lessons(groupID: groupID)
        map = { data in
            let json: JSON = parse(data)
            return parse(json[.lessons], Lesson.init)
        }
    }
}

// MARK: - GroupsConfiguration

public final class GroupsConfiguration: WebConfiguration {
    
    public let path: Path = .groups
    public let map: (Any?) -> [Group]
    
    public init() {
        map = { data in
            let json: JSON = parse(data)
            return parse(json[.groups], Group.init)
        }
    }
}
