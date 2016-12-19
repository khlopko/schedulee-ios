//
//  Lector.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Tools

public struct Lector: WebEntity {
    
    public let id: Int
    public let firstname: String
    public let lastname: String
    public let sorname: String
    
    public init(_ data: Any?) {
        let json: JSON = parse(data)
        id = parse(json[.id])
        firstname = parse(json[.firstname])
        lastname = parse(json[.lastname])
        sorname = parse(json[.sorname])
    }
}

public extension Lector {
    
    var fullname: String {
        return "\(lastname) \(firstname) \(sorname)"
    }
}
