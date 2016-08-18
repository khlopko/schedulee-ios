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
    public let fullname: String
    
    init(_ json: JSON?) {
        id = parse(json?[.id])
        fullname = parse(json?[.fullname])
    }
}
