//
//  TPumpSettingsOverrideDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 10/18/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import Foundation

public class TPumpSettingsOverrideDeviceEventDatum: TDeviceEventDatum, Decodable {
    public typealias BloodGlucoseTarget = TBloodGlucose.Target

    public enum OverrideType: String, Codable {
        case custom
        case physicalActivity
        case preprandial
        case preset
        case sleep
    }

    public enum Method: String, Codable {
        case automatic
        case manual
    }

    public var overrideType: OverrideType?
    public var overridePreset: String?
    public var method: Method?
    public var duration: TimeInterval?
    public var expectedDuration: TimeInterval?
    public var bloodGlucoseTarget: BloodGlucoseTarget?
    public var basalRateScaleFactor: Double?
    public var carbohydrateRatioScaleFactor: Double?
    public var insulinSensitivityScaleFactor: Double?
    public var units: Units?

    public init(time: Date,
                overrideType: OverrideType,
                overridePreset: String? = nil,
                method: Method? = nil,
                duration: TimeInterval? = nil,
                expectedDuration: TimeInterval? = nil,
                bloodGlucoseTarget: BloodGlucoseTarget? = nil,
                basalRateScaleFactor: Double? = nil,
                carbohydrateRatioScaleFactor: Double? = nil,
                insulinSensitivityScaleFactor: Double? = nil,
                units: Units? = nil) {
        self.overrideType = overrideType
        self.overridePreset = overridePreset
        self.method = method
        self.duration = duration
        self.expectedDuration = expectedDuration
        self.bloodGlucoseTarget = bloodGlucoseTarget
        self.basalRateScaleFactor = basalRateScaleFactor
        self.carbohydrateRatioScaleFactor = carbohydrateRatioScaleFactor
        self.insulinSensitivityScaleFactor = insulinSensitivityScaleFactor
        self.units = units
        super.init(.pumpSettingsOverride, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.overrideType = try container.decodeIfPresent(OverrideType.self, forKey: .overrideType)
        self.overridePreset = try container.decodeIfPresent(String.self, forKey: .overridePreset)
        self.method = try container.decodeIfPresent(Method.self, forKey: .method)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration).map { .seconds($0) }
        self.expectedDuration = try container.decodeIfPresent(Int.self, forKey: .expectedDuration).map { .seconds($0) }
        self.bloodGlucoseTarget = try container.decodeIfPresent(BloodGlucoseTarget.self, forKey: .bloodGlucoseTarget)
        self.basalRateScaleFactor = try container.decodeIfPresent(Double.self, forKey: .basalRateScaleFactor)
        self.carbohydrateRatioScaleFactor = try container.decodeIfPresent(Double.self, forKey: .carbohydrateRatioScaleFactor)
        self.insulinSensitivityScaleFactor = try container.decodeIfPresent(Double.self, forKey: .insulinSensitivityScaleFactor)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        try super.init(.pumpSettingsOverride, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(overrideType, forKey: .overrideType)
        try container.encodeIfPresent(overridePreset, forKey: .overridePreset)
        try container.encodeIfPresent(method, forKey: .method)
        try container.encodeIfPresent(duration.map { Int($0.seconds) }, forKey: .duration)
        try container.encodeIfPresent(expectedDuration.map { Int($0.seconds) }, forKey: .expectedDuration)
        try container.encodeIfPresent(bloodGlucoseTarget, forKey: .bloodGlucoseTarget)
        try container.encodeIfPresent(basalRateScaleFactor, forKey: .basalRateScaleFactor)
        try container.encodeIfPresent(carbohydrateRatioScaleFactor, forKey: .carbohydrateRatioScaleFactor)
        try container.encodeIfPresent(insulinSensitivityScaleFactor, forKey: .insulinSensitivityScaleFactor)
        try container.encodeIfPresent(units, forKey: .units)
        try super.encode(to: encoder)
    }

    public struct Units: Codable, Equatable {
        public typealias BloodGlucoseUnits = TBloodGlucose.Units

        public var bloodGlucose: BloodGlucoseUnits?

        public init(bloodGlucose: BloodGlucoseUnits? = nil) {
            self.bloodGlucose = bloodGlucose
        }

        private enum CodingKeys: String, CodingKey {
            case bloodGlucose = "bg"
        }
    }

    private enum CodingKeys: String, CodingKey {
        case overrideType
        case overridePreset
        case method
        case duration
        case expectedDuration
        case bloodGlucoseTarget = "bgTarget"
        case basalRateScaleFactor
        case carbohydrateRatioScaleFactor = "carbRatioScaleFactor"
        case insulinSensitivityScaleFactor
        case units
    }
}
