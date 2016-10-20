//
//  Logger.swift
//  Schedulee
//
//  Created by Kirill Khlopko on 8/18/16.
//  Copyright © 2016 Kirill Khlopko. All rights reserved.
//

import Foundation

public let log = Logger()

// MARK: - Logger

public final class Logger {

    /// Logger configuration parameters.
    public var config = Configuration()
    
    fileprivate let formatter = DateFormatter()
    
    public init() {
        formatter.dateFormat = dateFormat
    }
}

// MARK: - Interface

public extension Logger {
    
    typealias Parameter = Any
    
    /// Debug level logging.
    func d(_ params: Parameter...,
           separator: String = ",",
           file: String = #file,
           function: String = #function,
           line: Int = #line) {
        printMessage(
            params: params, separator: separator,
            file: file, function: function, line: line,
            level: .debug)
    }
    
    /// Info level logging.
    func i(_ params: Parameter...,
           separator: String = ",",
           file: String = #file,
           function: String = #function,
           line: Int = #line) {
        printMessage(
            params: params, separator: separator,
            file: file, function: function, line: line,
            level: .info)
    }
    
    /// Warning level logging.
    func w(_ params: Parameter...,
           separator: String = ",",
           file: String = #file,
           function: String = #function,
           line: Int = #line) {
        printMessage(
            params: params, separator: separator,
            file: file, function: function, line: line,
            level: .warning)
    }
    
    /// Error level loggin.
    func e(_ params: Parameter...,
           separator: String = ",",
           file: String = #file,
           function: String = #function,
           line: Int = #line) {
        printMessage(
            params: params, separator: separator,
            file: file, function: function, line: line,
            level: .error)
    }
}

// MARK: - Private

fileprivate extension Logger {
    
    func printMessage(params: Parameter...,
                      separator: String,
                      file: String,
                      function: String,
                      line: Int,
                      level: Level) {
        if level < config.minimalLogLevel {
            return
        }
        let message = params
            .map { "\($0)" }
            .joined(separator: separator)
            .trimmingCharacters(in: CharacterSet(charactersIn: "[]"))
        let shortFilename = file.components(separatedBy: "/").last ?? ""
        let date = formatter.string(from: Date())
        let details = Details(
            level: level, message: message, file: shortFilename,
            function: function, line: line, dateString: date)
        let logString = processDetails(details)
        print(logString)
    }
    
    func processDetails(_ details: Details) -> String {
        var string = ""
        if config.showDateAndTime {
            string += "[\(details.dateString)]"
        }
        if config.showLevel {
            string += "[\(details.level.presentationFormat.uppercased())]"
        }
        if config.showThread {
            string += "[\(makeThreadName())]"
        }
        if config.showFile {
            string += "[\(details.file)]"
        }
        if config.showFunction {
            string += "[\(details.function)]"
        }
        if config.showLine {
            string += "[\(details.line)]"
        }
        string += " > \(details.message)"
        return string
    }
    
    func makeThreadName() -> String {
        var str = "Thread "
        if Thread.isMainThread {
            str += "main"
        } else {
            if let threadName = Thread.current.name, threadName != "" {
                str += threadName
            } else {
                str += String(format:"%p", Thread.current)
            }
        }
        return str
    }
    
    func updateDateFormatter() {
        formatter.dateFormat = dateFormat
    }
    
    var dateFormat: String {
        var str = ""
        if config.showDate {
            str += "dd/MM/yyyy"
        }
        if config.showTime {
            if !str.isEmpty {
                str += " "
            }
            str += "HH:mm:ss:ms"
        }
        return str
    }
}

// MARK: - Configuration

extension Logger {
    
    /// Loggers structure that defines logger configuration.
    public struct Configuration {
        
        /// Should be date included to log message.
        public var showDate = false {
            didSet { log.updateDateFormatter() }
        }
        
        /// Should be time included to log message.
        public var showTime = true {
            didSet { log.updateDateFormatter() }
        }
        
        /// Should be date and included to log message.
        public var showDateAndTime = true
        
        /// Should include line number to log message.
        public var showLine = true
        
        /// Should include function name to log message.
        public var showFunction = true
        
        /// Should include file name to log message.
        public var showFile = true
        
        /// Should include log level to log message.
        public var showLevel = true
        
        /// Current minimal level of logs that showing.
        public var minimalLogLevel: Level = .debug
        
        /// Should include thread to log message.
        public var showThread = false
        
        fileprivate init() {
        }
    }
}

// MARK: - Level

extension Logger {
    
    /// Logging level.
    public enum Level: Int {
        
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        case none = 100
        
        fileprivate var presentationFormat: String {
            switch self {
            case .debug:
                return "debug"
            case .info:
                return "info"
            case .warning:
                return "warning"
            case .error:
                return "error"
            case .none:
                return "none"
            }
        }
    }
}

// MARK: - Comparable

extension Logger.Level: Comparable {
}

public func <(lhs: Logger.Level, rhs: Logger.Level) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func <=(lhs: Logger.Level, rhs: Logger.Level) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

public func >(lhs: Logger.Level, rhs: Logger.Level) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

public func >=(lhs: Logger.Level, rhs: Logger.Level) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

// MARK: - Details

extension Logger {
    
    fileprivate struct Details {
        
        let level: Level
        let message: String
        let file: String
        let function: String
        let line: Int
        let dateString: String
    }
}
