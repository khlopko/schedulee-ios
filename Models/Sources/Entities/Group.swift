//
//  Group.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 9/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public struct Group: WebEntity {
    
    public let id: Int
    public let title: String
    public let course: Int
    
    public init(_ data: Any?) {
        let json: JSON = parse(data)
        id = parse(json[.id])
        title = parse(json[.title])
        course = parse(json[.course])
    }
}
