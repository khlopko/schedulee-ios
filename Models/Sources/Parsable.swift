//
//  Mappable.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

func parse<In: AnyObject, Out: Parsable>(_ input: In?) -> Out {
    return Out(input)
}

protocol Parsable {
    init(_ object: AnyObject?)
}

extension String: Parsable {
    
    init(_ object: AnyObject?) {
        let string = object as? String ?? ""
        self.init(string)
    }
}

extension Int: Parsable {
    
    init(_ object: AnyObject?) {
        let value = object as? Int ?? 0
        self.init(value)
    }
}

extension Double: Parsable {
    
    init(_ object: AnyObject?) {
        let value = object as? Double ?? 0
        self.init(value)
    }
}
