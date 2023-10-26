//
//  TLogging.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/19/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

public protocol TLogging: AnyObject {

    ///
    /// Log a debug message.
    ///
    /// - Parameters
    ///   - message: The message to log.
    ///   - function: The function containing the message.
    ///   - file: The file containing the message.
    ///   - line: The line containing the message.
    func debug(_ message: String, function: StaticString, file: StaticString, line: UInt)

    ///
    /// Log a info message.
    ///
    /// - Parameters
    ///   - message: The message to log.
    ///   - function: The function containing the message.
    ///   - file: The file containing the message.
    ///   - line: The line containing the message.
    func info(_ message: String, function: StaticString, file: StaticString, line: UInt)

    ///
    /// Log a error message.
    ///
    /// - Parameters
    ///   - message: The message to log.
    ///   - function: The function containing the message.
    ///   - file: The file containing the message.
    ///   - line: The line containing the message.
    func error(_ message: String, function: StaticString, file: StaticString, line: UInt)
}

extension TLogging {
    public func debug(_ message: @autoclosure () -> String, function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
       debug(message(), function: function, file: file, line: line)
    }

    public func info(_ message: @autoclosure () -> String, function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
       info(message(), function: function, file: file, line: line)
    }

    public func error(_ message: @autoclosure () -> String, function: StaticString = #function, file: StaticString = #file, line: UInt = #line) {
       error(message(), function: function, file: file, line: line)
    }
}
