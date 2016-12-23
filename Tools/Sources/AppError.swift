//
//  AppError.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 12/20/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation
import Localization

public enum AppError: Error {
    
    case undefined
    
    public var localizedDescription: String {
        switch self {
        case .undefined:
            return Localized.undefinedError
        }
    }
}
