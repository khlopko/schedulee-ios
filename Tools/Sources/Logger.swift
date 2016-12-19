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

    /// Logger configuration parameters.
    public var config = Configuration()
    
    fileprivate let formatter = DateFormatter()
    
    public init() {
        formatter.dateFormat = dateFormat
    }
    
    public typealias Parameter = Any
    
    /// Debug level logging.
    ///
    /// - parameter params: Array of objects to log.
    /// - parameter separator: Separator between passed `params`.
    /// - parameter file: File in project.
    /// - parameter function: Called function.
    /// - parameter line: Line in function that called.
    ///
    public func d(_ params: Parameter...,
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
    ///
    /// - parameter params: Array of objects to log.
    /// - parameter separator: Separator between passed `params`.
    /// - parameter file: File in project.
    /// - parameter function: Called function.
    /// - parameter line: Line in function that called.
    ///
    public func i(_ params: Parameter...,
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
    ///
    /// - parameter params: Array of objects to log.
    /// - parameter separator: Separator between passed `params`.
    /// - parameter file: File in project.
    /// - parameter function: Called function.
    /// - parameter line: Line in function that called.
    ///
    public func w(_ params: Parameter...,
                    separator: String = ",",
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        printMessage(
            params: params, separator: separator,
            file: file, function: function, line: line,
            level: .warning)
    }
    
    /// Error level logging.
    ///
    /// - parameter params: Array of objects to log.
    /// - parameter separator: Separator between passed `params`.
    /// - parameter file: File in project.
    /// - parameter function: Called function.
    /// - parameter line: Line in function that called.
    ///
    public func e(_ params: Parameter...,
                    separator: String = ",",
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        printMessage(
            params: params, separator: separator,
            file: file, function: function, line: line,
            level: .error)
    }

    /// Measures time of executing code
    ///
    /// - parameter separator: Separator between passed `params`.
    /// - parameter file: File in project.
    /// - parameter function: Called function.
    /// - parameter line: Line in function that called.
    /// - parameter closure: Code to be measured.
    ///
    public func measure<T>(file: String = #file,
                           function: String = #function,
                           line: Int = #line,
                           _ closure: () -> (T)) -> T {
        let begin = CFAbsoluteTimeGetCurrent()
        let result = closure()
        printMessage(
            params: CFAbsoluteTimeGetCurrent() - begin, separator: "",
            file: file, function: function, line: line,
            level: .debug)
        return result
    }

    // MARK: - Private
    
    private func printMessage(params: Parameter...,
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
    
    private func processDetails(_ details: Details) -> String {
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
    
    private func makeThreadName() -> String {
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
    
    private var dateFormat: String {
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
    
    fileprivate func updateDateFormatter() {
        formatter.dateFormat = dateFormat
    }
}

// MARK: - Configuration

extension Logger {
    
    public struct Configuration {
        
        /// Should be date included to log message. Default is `false`
        public var showDate = false {
            didSet { log.updateDateFormatter() }
        }
        
        /// Should be time included to log message. Default is `true`
        public var showTime = true {
            didSet { log.updateDateFormatter() }
        }
        
        /// Should be date and included to log message. Default is `true`
        public var showDateAndTime = true
        
        /// Should include line number to log message. Default is `true`
        public var showLine = true
        
        /// Should include function name to log message. Default is `true`
        public var showFunction = true
        
        /// Should include file name to log message. Default is `true`
        public var showFile = true
        
        /// Should include log level to log message. Default is `true`
        public var showLevel = true
        
        /// Current minimal level of logs that showing. Default is `debug`
        public var minimalLogLevel: Level = .debug
        
        /// Should include thread to log message. Default is `false`
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
