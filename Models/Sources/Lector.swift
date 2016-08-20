//
//  Lector.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public struct Lector: WebEntity {
    
    public let id: String
    public let firstname: String
    public let lastname: String
    public let sorname: String
    
    public init(_ json: JSON?) {
        id = parse(json?[.id])
        firstname = parse(json?[.firstname])
        lastname = parse(json?[.lastname])
        sorname = parse(json?[.sorname])
    }
}

public extension Lector {
    
    var fullname: String {
        return "\(lastname) \(firstname) \(sorname)"
    }
}
