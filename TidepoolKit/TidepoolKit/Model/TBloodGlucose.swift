//
//  TBloodGlucose.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public struct TBloodGlucose {
    public enum Units: String, Codable {
        case milligramsPerDeciliter = "mg/dL"
        case millimolesPerLiter = "mmol/L"
    }

    public enum Trend: String, Codable {
        case constant
        case slowFall
        case slowRise
        case moderateFall
        case moderateRise
        case rapidFall
        case rapidRise
    }

    public struct Target: Codable, Equatable {
        public var target: Double?
        public var range: Double?
        public var low: Double?
        public var high: Double?

        public init(target: Double) {
            self.target = target
        }

        public init(target: Double, range: Double) {
            self.target = target
            self.range = range
        }

        public init(target: Double, high: Double) {
            self.target = target
            self.high = high
        }

        public init(low: Double, high: Double) {
            self.low = low
            self.high = high
        }
    }

    public struct StartTarget: Codable, Equatable {
        public var start: TimeInterval?
        public var target: Double?
        public var range: Double?
        public var low: Double?
        public var high: Double?

        public init(start: TimeInterval, target: Double) {
            self.start = start
            self.target = target
        }

        public init(start: TimeInterval, target: Double, range: Double) {
            self.start = start
            self.target = target
            self.range = range
        }

        public init(start: TimeInterval, target: Double, high: Double) {
            self.start = start
            self.target = target
            self.high = high
        }

        public init(start: TimeInterval, low: Double, high: Double) {
            self.start = start
            self.low = low
            self.high = high
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.start = try container.decodeIfPresent(Int.self, forKey: .start).map { .milliseconds($0) }
            self.target = try container.decodeIfPresent(Double.self, forKey: .target)
            self.range = try container.decodeIfPresent(Double.self, forKey: .range)
            self.low = try container.decodeIfPresent(Double.self, forKey: .low)
            self.high = try container.decodeIfPresent(Double.self, forKey: .high)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(start.map { Int($0.milliseconds) }, forKey: .start)
            try container.encodeIfPresent(target, forKey: .target)
            try container.encodeIfPresent(range, forKey: .range)
            try container.encodeIfPresent(low, forKey: .low)
            try container.encodeIfPresent(high, forKey: .high)
        }

        private enum CodingKeys: String, CodingKey {
            case start
            case target
            case range
            case low
            case high
        }
    }

    public static func valueRange(for units: Units) -> ClosedRange<Double> {
        switch units {
        case .milligramsPerDeciliter:
            return 0...1000
        case .millimolesPerLiter:
            return 0...55.0
        }
    }

    public static func clamp(value: Double, for units: Units) -> Double {
        let range = valueRange(for: units)
        return min(max(value, range.lowerBound), range.upperBound)
    }
}
