//
//  Logging.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 1/17/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import os.log
import TidepoolKit

class Logging: TLogging {
    func debug(_ message: String, function: StaticString, file: StaticString, line: UInt) {
        os_log("DEBUG: %{public}@ %{public}@", type: .debug, message, location(function: function, file: file, line: line))
    }

    func info(_ message: String, function: StaticString, file: StaticString, line: UInt) {
        os_log("INFO: %{public}@ %{public}@", type: .info, message, location(function: function, file: file, line: line))
    }

    func error(_ message: String, function: StaticString, file: StaticString, line: UInt) {
        os_log("ERROR: %{public}@ %{public}@", type: .error, message, location(function: function, file: file, line: line))
    }

    private func location(function: StaticString, file: StaticString, line: UInt) -> String {
        return "[\(URL(fileURLWithPath: file.description).lastPathComponent):\(line):\(function)]"
    }
}
