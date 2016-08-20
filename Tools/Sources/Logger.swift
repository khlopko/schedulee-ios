//
//  Logger.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public let log = Logger()

public final class Logger {
    
    public func d(_ params: AnyObject...,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        print(makeString(params, file: file, function: function, line: line, level: .debug))
    }
    
    public func i(_ params: AnyObject...,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        print(makeString(params, file: file, function: function, line: line, level: .info))
    }
    
    public func w(_ params: AnyObject...,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        print(makeString(params, file: file, function: function, line: line, level: .warning))
    }
    
    public func e(_ params: AnyObject...,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        print(makeString(params, file: file, function: function, line: line, level: .error))
    }
    
    private func makeString(_ params: AnyObject...,
                              file: String,
                              function: String,
                              line: Int,
                              level: Level) -> String {
        let output = params.map {"\($0)"}.joined(separator: ", ").trimmingCharacters(in: .newlines)
        let shortFilename = file.components(separatedBy: "/").last ?? ""
        let date = formatter.string(from: Date())
        return "[\(date)][\(level.presentationFormat)] \(shortFilename)::\(function)[\(line)]: " + output
    }
    
    private let formatter = DateFormatter() ->> {
        $0.dateFormat = "dd/MM/yyyy HH:mm:ss:ms"
    }
    
    private enum Level: String {
        
        case debug = "debug"
        case info = "info"
        case warning = "warning"
        case error = "error"
        
        var presentationFormat: String {
            return "\(rawValue.uppercased())"
        }
    }
}
