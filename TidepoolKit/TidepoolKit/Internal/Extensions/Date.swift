//
//  Date.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/5/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

extension Date {
    init?(timeString: String) {
        if let date = Date.timeFormatter.date(from: timeString) {
            self = date.roundedToTimeInterval(.millisecond)
        } else if let date = Date.timeFormatterAlternate.date(from: timeString) {
            self = date.roundedToTimeInterval(.millisecond)
        } else {
            return nil
        }
    }

    init?(deviceTimeString: String) {
        if let date = Date.deviceTimeFormatter.date(from: deviceTimeString) {
            self = date.roundedToTimeInterval(.millisecond)
        } else if let date = Date.deviceTimeFormatterAlternate.date(from: deviceTimeString) {
            self = date.roundedToTimeInterval(.millisecond)
        } else {
            return nil
        }
    }

    var timeString: String {
        return Date.timeFormatter.string(from: self.roundedToTimeInterval(.millisecond))
    }

    var deviceTimeString: String {
        return Date.deviceTimeFormatter.string(from: self.roundedToTimeInterval(.millisecond))
    }

    private static let timeFormatter: ISO8601DateFormatter = {
        var timeFormatter = ISO8601DateFormatter()
        timeFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return timeFormatter
    }()

    private static let timeFormatterAlternate: ISO8601DateFormatter = {
        var timeFormatter = ISO8601DateFormatter()
        timeFormatter.formatOptions = [.withInternetDateTime]
        return timeFormatter
    }()

    private static let deviceTimeFormatter: ISO8601DateFormatter = {
        var timeFormatter = ISO8601DateFormatter()
        timeFormatter.formatOptions = [.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withFractionalSeconds]
        return timeFormatter
    }()

    private static let deviceTimeFormatterAlternate: ISO8601DateFormatter = {
        var timeFormatter = ISO8601DateFormatter()
        timeFormatter.formatOptions = [.withFullDate, .withFullTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        return timeFormatter
    }()

    private func roundedToTimeInterval(_ interval: TimeInterval) -> Date {
        guard interval != 0 else {
            return self
        }
        return Date(timeIntervalSinceReferenceDate: round(self.timeIntervalSinceReferenceDate / interval) * interval)
    }
}
