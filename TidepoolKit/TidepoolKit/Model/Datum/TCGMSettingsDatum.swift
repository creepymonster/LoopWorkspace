//
//  TCGMSettingsDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TCGMSettingsDatum: TDatum, Decodable {
    public typealias Units = TBloodGlucose.Units

    public var firmwareVersion: String?
    public var hardwareVersion: String?
    public var manufacturers: [String]?
    public var model: String?
    public var name: String?
    public var serialNumber: String?
    public var softwareVersion: String?
    public var transmitterId: String?
    public var units: Units?
    public var defaultAlerts: Alerts?
    public var scheduledAlerts: [ScheduledAlert]?

    public var highAlertsDEPRECATED: LevelAlertsDEPRECATED?
    public var lowAlertsDEPRECATED: LevelAlertsDEPRECATED?
    public var outOfRangeAlertsDEPRECATED: OutOfRangeAlertsDEPRECATED?
    public var rateOfChangeAlertsDEPRECATED: RateOfChangeAlertsDEPRECATED?

    public init(time: Date,
                firmwareVersion: String? = nil,
                hardwareVersion: String? = nil,
                manufacturers: [String]? = nil,
                model: String? = nil,
                name: String? = nil,
                serialNumber: String? = nil,
                softwareVersion: String? = nil,
                transmitterId: String? = nil,
                units: Units? = nil,
                defaultAlerts: Alerts? = nil,
                scheduledAlerts: [ScheduledAlert]? = nil) {
        self.firmwareVersion = firmwareVersion
        self.hardwareVersion = hardwareVersion
        self.manufacturers = manufacturers
        self.model = model
        self.name = name
        self.serialNumber = serialNumber
        self.softwareVersion = softwareVersion
        self.transmitterId = transmitterId
        self.units = units
        self.defaultAlerts = defaultAlerts
        self.scheduledAlerts = scheduledAlerts
        super.init(.cgmSettings, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firmwareVersion = try container.decodeIfPresent(String.self, forKey: .firmwareVersion)
        self.hardwareVersion = try container.decodeIfPresent(String.self, forKey: .hardwareVersion)
        self.manufacturers = try container.decodeIfPresent([String].self, forKey: .manufacturers)
        self.model = try container.decodeIfPresent(String.self, forKey: .model)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
        self.softwareVersion = try container.decodeIfPresent(String.self, forKey: .softwareVersion)
        self.transmitterId = try container.decodeIfPresent(String.self, forKey: .transmitterId)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        self.defaultAlerts = try container.decodeIfPresent(Alerts.self, forKey: .defaultAlerts)
        self.scheduledAlerts = try container.decodeIfPresent([ScheduledAlert].self, forKey: .scheduledAlerts)
        self.highAlertsDEPRECATED = try container.decodeIfPresent(LevelAlertsDEPRECATED.self, forKey: .highAlertsDEPRECATED)
        self.lowAlertsDEPRECATED = try container.decodeIfPresent(LevelAlertsDEPRECATED.self, forKey: .lowAlertsDEPRECATED)
        self.outOfRangeAlertsDEPRECATED = try container.decodeIfPresent(OutOfRangeAlertsDEPRECATED.self, forKey: .outOfRangeAlertsDEPRECATED)
        self.rateOfChangeAlertsDEPRECATED = try container.decodeIfPresent(RateOfChangeAlertsDEPRECATED.self, forKey: .rateOfChangeAlertsDEPRECATED)
        try super.init(.cgmSettings, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(firmwareVersion, forKey: .firmwareVersion)
        try container.encodeIfPresent(hardwareVersion, forKey: .hardwareVersion)
        try container.encodeIfPresent(manufacturers, forKey: .manufacturers)
        try container.encodeIfPresent(model, forKey: .model)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(serialNumber, forKey: .serialNumber)
        try container.encodeIfPresent(softwareVersion, forKey: .softwareVersion)
        try container.encodeIfPresent(transmitterId, forKey: .transmitterId)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(defaultAlerts, forKey: .defaultAlerts)
        try container.encodeIfPresent(scheduledAlerts, forKey: .scheduledAlerts)
        try container.encodeIfPresent(highAlertsDEPRECATED, forKey: .highAlertsDEPRECATED)
        try container.encodeIfPresent(lowAlertsDEPRECATED, forKey: .lowAlertsDEPRECATED)
        try container.encodeIfPresent(outOfRangeAlertsDEPRECATED, forKey: .outOfRangeAlertsDEPRECATED)
        try container.encodeIfPresent(rateOfChangeAlertsDEPRECATED, forKey: .rateOfChangeAlertsDEPRECATED)
        try super.encode(to: encoder)
    }

    public struct Alerts: Codable, Equatable {
        public var enabled: Bool?
        public var urgentLow: LevelAlert?
        public var urgentLowPredicted: LevelAlert?
        public var low: LevelAlert?
        public var lowPredicted: LevelAlert?
        public var high: LevelAlert?
        public var highPredicted: LevelAlert?
        public var fall: RateAlert?
        public var rise: RateAlert?
        public var noData: DurationAlert?
        public var outOfRange: DurationAlert?

        public init(enabled: Bool, urgentLow: LevelAlert? = nil, urgentLowPredicted: LevelAlert? = nil, low: LevelAlert? = nil, lowPredicted: LevelAlert? = nil, high: LevelAlert? = nil, highPredicted: LevelAlert? = nil, fall: RateAlert? = nil, rise: RateAlert? = nil, noData: DurationAlert? = nil, outOfRange: DurationAlert? = nil) {
            self.enabled = enabled
            self.urgentLow = urgentLow
            self.urgentLowPredicted = urgentLowPredicted
            self.low = low
            self.lowPredicted = lowPredicted
            self.high = high
            self.highPredicted = highPredicted
            self.fall = fall
            self.rise = rise
            self.noData = noData
            self.outOfRange = outOfRange
        }

        public struct DurationAlert: Codable, Equatable {
            public enum Units: String, Codable {
                case hours
                case minutes
                case seconds
            }

            public var enabled: Bool?
            public var duration: Double?
            public var units: Units?
            public var snooze: Snooze?

            public init(enabled: Bool, duration: Double, units: Units, snooze: Snooze? = nil) {
                self.enabled = enabled
                self.duration = duration
                self.units = units
                self.snooze = snooze
            }
        }

        public struct LevelAlert: Codable, Equatable {
            public typealias Units = TBloodGlucose.Units

            public var enabled: Bool?
            public var level: Double?
            public var units: Units?
            public var snooze: Snooze?

            public init(enabled: Bool, level: Double, units: Units, snooze: Snooze? = nil) {
                self.enabled = enabled
                self.level = level
                self.units = units
                self.snooze = snooze
            }
        }

        public struct RateAlert: Codable, Equatable {
            public enum Units: String, Codable {
                case milligramsPerDeciliterPerMinute = "mg/dL/minute"
                case millimolesPerLiterPerMinute = "mmol/L/minute"
            }

            public var enabled: Bool?
            public var rate: Double?
            public var units: Units?
            public var snooze: Snooze?

            public init(enabled: Bool, rate: Double, units: Units, snooze: Snooze? = nil) {
                self.enabled = enabled
                self.rate = rate
                self.units = units
                self.snooze = snooze
            }
        }

        public struct Snooze: Codable, Equatable {
            public enum Units: String, Codable {
                case hours
                case minutes
                case seconds
            }

            public var duration: Double?
            public var units: Units?

            public init(_ duration: Double, _ units: Units) {
                self.duration = duration
                self.units = units
            }
        }
    }

    public struct ScheduledAlert: Codable, Equatable {
        public var name: String?
        public var days: [String]?
        public var start: TimeInterval?
        public var end: TimeInterval?
        public var alerts: Alerts?

        public init(name: String? = nil, days: [String]? = nil, start: TimeInterval? = nil, end: TimeInterval? = nil, alerts: Alerts? = nil) {
            self.name = name
            self.days = days
            self.start = start
            self.end = end
            self.alerts = alerts
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.days = try container.decodeIfPresent([String].self, forKey: .days)
            self.start = try container.decodeIfPresent(Int.self, forKey: .start).map { .milliseconds($0) }
            self.end = try container.decodeIfPresent(Int.self, forKey: .end).map { .milliseconds($0) }
            self.alerts = try container.decodeIfPresent(Alerts.self, forKey: .alerts)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(days, forKey: .days)
            try container.encodeIfPresent(start.map { Int($0.milliseconds) }, forKey: .start)
            try container.encodeIfPresent(end.map { Int($0.milliseconds) }, forKey: .end)
            try container.encodeIfPresent(alerts, forKey: .alerts)
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case days
            case start
            case end
            case alerts
        }
    }

    public struct LevelAlertsDEPRECATED: Codable, Equatable {
        public var enabled: Bool?
        public var level: Double?
        public var snooze: TimeInterval?

        public init(enabled: Bool? = nil, level: Double? = nil, snooze: TimeInterval? = nil) {
            self.enabled = enabled
            self.level = level
            self.snooze = snooze
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.level = try container.decodeIfPresent(Double.self, forKey: .level)
            self.snooze = try container.decodeIfPresent(Int.self, forKey: .snooze).map { .milliseconds($0) }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(enabled, forKey: .enabled)
            try container.encodeIfPresent(level, forKey: .level)
            try container.encodeIfPresent(snooze.map { Int($0.milliseconds) }, forKey: .snooze)
        }

        private enum CodingKeys: String, CodingKey {
            case enabled
            case level
            case snooze
        }
    }

    public struct OutOfRangeAlertsDEPRECATED: Codable, Equatable {
        public var enabled: Bool?
        public var snooze: TimeInterval?

        public init(enabled: Bool? = nil, snooze: TimeInterval? = nil) {
            self.enabled = enabled
            self.snooze = snooze
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled)
            self.snooze = try container.decodeIfPresent(Int.self, forKey: .snooze).map { .milliseconds($0) }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(enabled, forKey: .enabled)
            try container.encodeIfPresent(snooze.map { Int($0.milliseconds) }, forKey: .snooze)
        }

        private enum CodingKeys: String, CodingKey {
            case enabled
            case snooze
        }
    }

    public struct RateOfChangeAlertsDEPRECATED: Codable, Equatable {
        public var fallRate: RateAlert?
        public var riseRate: RateAlert?

        public init(fallRate: RateAlert? = nil, riseRate: RateAlert? = nil) {
            self.fallRate = fallRate
            self.riseRate = riseRate
        }

        public struct RateAlert: Codable, Equatable {
            public var enabled: Bool?
            public var rate: Double?

            public init(enabled: Bool? = nil, rate: Double? = nil) {
                self.enabled = enabled
                self.rate = rate
            }
        }
    }

    private enum CodingKeys: String, CodingKey {
        case firmwareVersion
        case hardwareVersion
        case manufacturers
        case model
        case name
        case serialNumber
        case softwareVersion
        case transmitterId
        case units
        case defaultAlerts
        case scheduledAlerts
        case highAlertsDEPRECATED = "highAlerts"
        case lowAlertsDEPRECATED = "lowAlerts"
        case outOfRangeAlertsDEPRECATED = "outOfRangeAlerts"
        case rateOfChangeAlertsDEPRECATED = "rateOfChangeAlerts"
    }
}
