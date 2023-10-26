//
//  TPumpSettingsDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TPumpSettingsDatum: TDatum, Decodable {
    public typealias BloodGlucoseTarget = TBloodGlucose.Target
    public typealias BloodGlucoseStartTarget = TBloodGlucose.StartTarget
    public typealias InsulinFormulation = TInsulinDatum.Formulation

    public var activeScheduleName: String?
    public var automatedDelivery: Bool?
    public var basal: Basal?
    public var basalRateSchedule: [BasalRateStart]?
    public var basalRateSchedules: [String: [BasalRateStart]]?
    public var bloodGlucoseSafetyLimit: Double?
    public var bloodGlucoseTargetPhysicalActivity: BloodGlucoseTarget?
    public var bloodGlucoseTargetPreprandial: BloodGlucoseTarget?
    public var bloodGlucoseTargetSchedule: [BloodGlucoseStartTarget]?
    public var bloodGlucoseTargetSchedules: [String: [BloodGlucoseStartTarget]]?
    public var bolus: Bolus?
    public var carbohydrateRatioSchedule: [CarbohydrateRatioStart]?
    public var carbohydrateRatioSchedules: [String: [CarbohydrateRatioStart]]?
    public var display: Display?
    public var firmwareVersion: String?
    public var hardwareVersion: String?
    public var insulinFormulation: InsulinFormulation?
    public var insulinModel: InsulinModel?
    public var insulinSensitivitySchedule: [InsulinSensitivityStart]?
    public var insulinSensitivitySchedules: [String: [InsulinSensitivityStart]]?
    public var manufacturers: [String]?
    public var model: String?
    public var name: String?
    public var overridePresets: [String: OverridePreset]?
    public var scheduleTimeZoneOffset: TimeInterval?
    public var serialNumber: String?
    public var softwareVersion: String?
    public var units: Units?
    
    public init(time: Date,
                activeScheduleName: String? = nil,
                automatedDelivery: Bool? = nil,
                basal: Basal? = nil,
                basalRateSchedule: [BasalRateStart]? = nil,
                basalRateSchedules: [String: [BasalRateStart]]? = nil,
                bloodGlucoseSafetyLimit: Double? = nil,
                bloodGlucoseTargetPhysicalActivity: BloodGlucoseTarget? = nil,
                bloodGlucoseTargetPreprandial: BloodGlucoseTarget? = nil,
                bloodGlucoseTargetSchedule: [BloodGlucoseStartTarget]? = nil,
                bloodGlucoseTargetSchedules: [String: [BloodGlucoseStartTarget]]? = nil,
                bolus: Bolus? = nil,
                carbohydrateRatioSchedule: [CarbohydrateRatioStart]? = nil,
                carbohydrateRatioSchedules: [String: [CarbohydrateRatioStart]]? = nil,
                display: Display? = nil,
                firmwareVersion: String? = nil,
                hardwareVersion: String? = nil,
                insulinFormulation: InsulinFormulation? = nil,
                insulinModel: InsulinModel? = nil,
                insulinSensitivitySchedule: [InsulinSensitivityStart]? = nil,
                insulinSensitivitySchedules: [String: [InsulinSensitivityStart]]? = nil,
                manufacturers: [String]? = nil,
                model: String? = nil,
                name: String? = nil,
                overridePresets: [String: OverridePreset]? = nil,
                scheduleTimeZoneOffset: TimeInterval? = nil,
                serialNumber: String? = nil,
                softwareVersion: String? = nil,
                units: Units? = nil) {
        self.activeScheduleName = activeScheduleName
        self.automatedDelivery = automatedDelivery
        self.basal = basal
        self.basalRateSchedule = basalRateSchedule
        self.basalRateSchedules = basalRateSchedules
        self.bloodGlucoseSafetyLimit = bloodGlucoseSafetyLimit
        self.bloodGlucoseTargetPhysicalActivity = bloodGlucoseTargetPhysicalActivity
        self.bloodGlucoseTargetPreprandial = bloodGlucoseTargetPreprandial
        self.bloodGlucoseTargetSchedule = bloodGlucoseTargetSchedule
        self.bloodGlucoseTargetSchedules = bloodGlucoseTargetSchedules
        self.bolus = bolus
        self.carbohydrateRatioSchedule = carbohydrateRatioSchedule
        self.carbohydrateRatioSchedules = carbohydrateRatioSchedules
        self.display = display
        self.firmwareVersion = firmwareVersion
        self.hardwareVersion = hardwareVersion
        self.insulinFormulation = insulinFormulation
        self.insulinModel = insulinModel
        self.insulinSensitivitySchedule = insulinSensitivitySchedule
        self.insulinSensitivitySchedules = insulinSensitivitySchedules
        self.manufacturers = manufacturers
        self.model = model
        self.name = name
        self.overridePresets = overridePresets
        self.scheduleTimeZoneOffset = scheduleTimeZoneOffset
        self.serialNumber = serialNumber
        self.softwareVersion = softwareVersion
        self.units = units
        super.init(.pumpSettings, time: time)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activeScheduleName = try container.decodeIfPresent(String.self, forKey: .activeScheduleName)
        self.automatedDelivery = try container.decodeIfPresent(Bool.self, forKey: .automatedDelivery)
        self.basal = try container.decodeIfPresent(Basal.self, forKey: .basal)
        self.basalRateSchedule = try container.decodeIfPresent([BasalRateStart].self, forKey: .basalRateSchedule)
        self.basalRateSchedules = try container.decodeIfPresent([String: [BasalRateStart]].self, forKey: .basalRateSchedules)
        self.bloodGlucoseSafetyLimit = try container.decodeIfPresent(Double.self, forKey: .bloodGlucoseSafetyLimit)
        self.bloodGlucoseTargetPhysicalActivity = try container.decodeIfPresent(BloodGlucoseTarget.self, forKey: .bloodGlucoseTargetPhysicalActivity)
        self.bloodGlucoseTargetPreprandial = try container.decodeIfPresent(BloodGlucoseTarget.self, forKey: .bloodGlucoseTargetPreprandial)
        self.bloodGlucoseTargetSchedule = try container.decodeIfPresent([BloodGlucoseStartTarget].self, forKey: .bloodGlucoseTargetSchedule)
        self.bloodGlucoseTargetSchedules = try container.decodeIfPresent([String: [BloodGlucoseStartTarget]].self, forKey: .bloodGlucoseTargetSchedules)
        self.bolus = try container.decodeIfPresent(Bolus.self, forKey: .bolus)
        self.carbohydrateRatioSchedule = try container.decodeIfPresent([CarbohydrateRatioStart].self, forKey: .carbohydrateRatioSchedule)
        self.carbohydrateRatioSchedules = try container.decodeIfPresent([String: [CarbohydrateRatioStart]].self, forKey: .carbohydrateRatioSchedules)
        self.display = try container.decodeIfPresent(Display.self, forKey: .display)
        self.firmwareVersion = try container.decodeIfPresent(String.self, forKey: .firmwareVersion)
        self.hardwareVersion = try container.decodeIfPresent(String.self, forKey: .hardwareVersion)
        self.insulinFormulation = try container.decodeIfPresent(InsulinFormulation.self, forKey: .insulinFormulation)
        self.insulinModel = try container.decodeIfPresent(InsulinModel.self, forKey: .insulinModel)
        self.insulinSensitivitySchedule = try container.decodeIfPresent([InsulinSensitivityStart].self, forKey: .insulinSensitivitySchedule)
        self.insulinSensitivitySchedules = try container.decodeIfPresent([String: [InsulinSensitivityStart]].self, forKey: .insulinSensitivitySchedules)
        self.manufacturers = try container.decodeIfPresent([String].self, forKey: .manufacturers)
        self.model = try container.decodeIfPresent(String.self, forKey: .model)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.overridePresets = try container.decodeIfPresent([String: OverridePreset].self, forKey: .overridePresets)
        self.scheduleTimeZoneOffset = try container.decodeIfPresent(Int.self, forKey: .scheduleTimeZoneOffset).map { .minutes($0) }
        self.serialNumber = try container.decodeIfPresent(String.self, forKey: .serialNumber)
        self.softwareVersion = try container.decodeIfPresent(String.self, forKey: .softwareVersion)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        try super.init(.pumpSettings, from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(activeScheduleName, forKey: .activeScheduleName)
        try container.encodeIfPresent(automatedDelivery, forKey: .automatedDelivery)
        try container.encodeIfPresent(basal, forKey: .basal)
        try container.encodeIfPresent(basalRateSchedule, forKey: .basalRateSchedule)
        try container.encodeIfPresent(basalRateSchedules, forKey: .basalRateSchedules)
        try container.encodeIfPresent(bloodGlucoseSafetyLimit, forKey: .bloodGlucoseSafetyLimit)
        try container.encodeIfPresent(bloodGlucoseTargetPhysicalActivity, forKey: .bloodGlucoseTargetPhysicalActivity)
        try container.encodeIfPresent(bloodGlucoseTargetPreprandial, forKey: .bloodGlucoseTargetPreprandial)
        try container.encodeIfPresent(bloodGlucoseTargetSchedule, forKey: .bloodGlucoseTargetSchedule)
        try container.encodeIfPresent(bloodGlucoseTargetSchedules, forKey: .bloodGlucoseTargetSchedules)
        try container.encodeIfPresent(bolus, forKey: .bolus)
        try container.encodeIfPresent(carbohydrateRatioSchedule, forKey: .carbohydrateRatioSchedule)
        try container.encodeIfPresent(carbohydrateRatioSchedules, forKey: .carbohydrateRatioSchedules)
        try container.encodeIfPresent(display, forKey: .display)
        try container.encodeIfPresent(firmwareVersion, forKey: .firmwareVersion)
        try container.encodeIfPresent(hardwareVersion, forKey: .hardwareVersion)
        try container.encodeIfPresent(insulinFormulation, forKey: .insulinFormulation)
        try container.encodeIfPresent(insulinModel, forKey: .insulinModel)
        try container.encodeIfPresent(insulinSensitivitySchedule, forKey: .insulinSensitivitySchedule)
        try container.encodeIfPresent(insulinSensitivitySchedules, forKey: .insulinSensitivitySchedules)
        try container.encodeIfPresent(manufacturers, forKey: .manufacturers)
        try container.encodeIfPresent(model, forKey: .model)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(overridePresets, forKey: .overridePresets)
        try container.encodeIfPresent(scheduleTimeZoneOffset.map { Int($0.minutes) }, forKey: .scheduleTimeZoneOffset)
        try container.encodeIfPresent(serialNumber, forKey: .serialNumber)
        try container.encodeIfPresent(softwareVersion, forKey: .softwareVersion)
        try container.encodeIfPresent(units, forKey: .units)
        try super.encode(to: encoder)
    }
    
    public struct Basal: Codable, Equatable {
        public var rateMaximum: RateMaximum?
        public var temporary: Temporary?
        
        public init(rateMaximum: RateMaximum? = nil, temporary: Temporary? = nil) {
            self.rateMaximum = rateMaximum
            self.temporary = temporary
        }
        
        public struct RateMaximum: Codable, Equatable {
            public typealias Units = TInsulin.RateUnits

            public var value: Double?
            public var units: Units?
            
            public init(_ value: Double, _ units: Units = .unitsPerHour) {
                self.value = value
                self.units = units
            }
        }
        
        public struct Temporary: Codable, Equatable {
            public enum TemporaryType: String, Codable {
                case off
                case percent
                case unitsPerHour = "Units/hour"
            }
            
            public var type: TemporaryType?
            
            public init(_ type: TemporaryType) {
                self.type = type
            }
        }
    }
    
    public struct BasalRateStart: Codable, Equatable {
        public var start: TimeInterval?
        public var rate: Double?
        
        public init(start: TimeInterval, rate: Double) {
            self.start = start
            self.rate = rate
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.start = try container.decodeIfPresent(Int.self, forKey: .start).map { .milliseconds($0) }
            self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(start.map { Int($0.milliseconds) }, forKey: .start)
            try container.encodeIfPresent(rate, forKey: .rate)
        }

        private enum CodingKeys: String, CodingKey {
            case start
            case rate
        }
    }

    public struct Bolus: Codable, Equatable {
        public var amountMaximum: AmountMaximum?
        public var calculator: Calculator?
        public var extended: Extended?
        
        public init(amountMaximum: AmountMaximum? = nil, calculator: Calculator? = nil, extended: Extended? = nil) {
            self.amountMaximum = amountMaximum
            self.calculator = calculator
            self.extended = extended
        }
        
        public struct AmountMaximum: Codable, Equatable {
            public typealias Units = TInsulin.Units

            public var value: Double?
            public var units: Units?
            
            public init(_ value: Double, _ units: Units = .units) {
                self.value = value
                self.units = units
            }
        }
        
        public struct Calculator: Codable, Equatable {
            public var enabled: Bool?
            public var insulin: Insulin?
            
            public init(enabled: Bool, insulin: Insulin) {
                self.enabled = enabled
                self.insulin = insulin
            }
            
            public struct Insulin: Codable, Equatable {
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
        
        public struct Extended: Codable, Equatable {
            public var enabled: Bool?
            
            public init(enabled: Bool) {
                self.enabled = enabled
            }
        }
    }
    
    public struct CarbohydrateRatioStart: Codable, Equatable {
        public var start: TimeInterval?
        public var amount: Double?
        
        public init(start: TimeInterval, amount: Double) {
            self.start = start
            self.amount = amount
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.start = try container.decodeIfPresent(Int.self, forKey: .start).map { .milliseconds($0) }
            self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(start.map { Int($0.milliseconds) }, forKey: .start)
            try container.encodeIfPresent(amount, forKey: .amount)
        }

        private enum CodingKeys: String, CodingKey {
            case start
            case amount
        }
    }
    
    public struct Display: Codable, Equatable {
        public var bloodGlucose: BloodGlucose?
        
        public init(bloodGlucose: BloodGlucose) {
            self.bloodGlucose = bloodGlucose
        }
        
        public struct BloodGlucose: Codable, Equatable {
            public typealias Units = TBloodGlucose.Units
            
            public var units: Units?
            
            public init(_ units: Units) {
                self.units = units
            }
        }
    }

    public struct InsulinModel: Codable, Equatable {
        public enum ModelType: String, Codable {
            case fiasp
            case other
            case rapidAdult
            case rapidChild
            case walsh
        }

        public var modelType: ModelType?
        public var modelTypeOther: String?
        public var actionDelay: TimeInterval?
        public var actionDuration: TimeInterval?
        public var actionPeakOffset: TimeInterval?

        public init(modelType: ModelType? = nil, modelTypeOther: String? = nil, actionDelay: TimeInterval? = nil, actionDuration: TimeInterval? = nil, actionPeakOffset: TimeInterval? = nil) {
            self.modelType = modelType
            self.modelTypeOther = modelTypeOther
            self.actionDelay = actionDelay
            self.actionDuration = actionDuration
            self.actionPeakOffset = actionPeakOffset
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.modelType = try container.decodeIfPresent(ModelType.self, forKey: .modelType)
            self.modelTypeOther = try container.decodeIfPresent(String.self, forKey: .modelTypeOther)
            self.actionDelay = try container.decodeIfPresent(Int.self, forKey: .actionDelay).map { .seconds($0) }
            self.actionDuration = try container.decodeIfPresent(Int.self, forKey: .actionDuration).map { .seconds($0) }
            self.actionPeakOffset = try container.decodeIfPresent(Int.self, forKey: .actionPeakOffset).map { .seconds($0) }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(modelType, forKey: .modelType)
            try container.encodeIfPresent(modelTypeOther, forKey: .modelTypeOther)
            try container.encodeIfPresent(actionDelay.map { Int($0.seconds) }, forKey: .actionDelay)
            try container.encodeIfPresent(actionDuration.map { Int($0.seconds) }, forKey: .actionDuration)
            try container.encodeIfPresent(actionPeakOffset.map { Int($0.seconds) }, forKey: .actionPeakOffset)
        }

        private enum CodingKeys: String, CodingKey {
            case modelType
            case modelTypeOther
            case actionDelay
            case actionDuration
            case actionPeakOffset
        }
    }
    
    public struct InsulinSensitivityStart: Codable, Equatable {
        public var start: TimeInterval?
        public var amount: Double?
        
        public init(start: TimeInterval, amount: Double) {
            self.start = start
            self.amount = amount
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.start = try container.decodeIfPresent(Int.self, forKey: .start).map { .milliseconds($0) }
            self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(start.map { Int($0.milliseconds) }, forKey: .start)
            try container.encodeIfPresent(amount, forKey: .amount)
        }

        private enum CodingKeys: String, CodingKey {
            case start
            case amount
        }
    }

    public struct OverridePreset: Codable, Equatable {
        public var abbreviation: String?
        public var duration: TimeInterval?
        public var bloodGlucoseTarget: BloodGlucoseTarget?
        public var basalRateScaleFactor: Double?
        public var carbohydrateRatioScaleFactor: Double?
        public var insulinSensitivityScaleFactor: Double?

        public init(abbreviation: String? = nil, duration: TimeInterval? = nil, bloodGlucoseTarget: BloodGlucoseTarget? = nil, basalRateScaleFactor: Double? = nil, carbohydrateRatioScaleFactor: Double? = nil, insulinSensitivityScaleFactor: Double? = nil) {
            self.abbreviation = abbreviation
            self.duration = duration
            self.bloodGlucoseTarget = bloodGlucoseTarget
            self.basalRateScaleFactor = basalRateScaleFactor
            self.carbohydrateRatioScaleFactor = carbohydrateRatioScaleFactor
            self.insulinSensitivityScaleFactor = insulinSensitivityScaleFactor
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.abbreviation = try container.decodeIfPresent(String.self, forKey: .abbreviation)
            self.duration = try container.decodeIfPresent(Int.self, forKey: .duration).map { .seconds($0) }
            self.bloodGlucoseTarget = try container.decodeIfPresent(BloodGlucoseTarget.self, forKey: .bloodGlucoseTarget)
            self.basalRateScaleFactor = try container.decodeIfPresent(Double.self, forKey: .basalRateScaleFactor)
            self.carbohydrateRatioScaleFactor = try container.decodeIfPresent(Double.self, forKey: .carbohydrateRatioScaleFactor)
            self.insulinSensitivityScaleFactor = try container.decodeIfPresent(Double.self, forKey: .insulinSensitivityScaleFactor)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(abbreviation, forKey: .abbreviation)
            try container.encodeIfPresent(duration.map { Int($0.seconds) }, forKey: .duration)
            try container.encodeIfPresent(bloodGlucoseTarget, forKey: .bloodGlucoseTarget)
            try container.encodeIfPresent(basalRateScaleFactor, forKey: .basalRateScaleFactor)
            try container.encodeIfPresent(carbohydrateRatioScaleFactor, forKey: .carbohydrateRatioScaleFactor)
            try container.encodeIfPresent(insulinSensitivityScaleFactor, forKey: .insulinSensitivityScaleFactor)
        }

        private enum CodingKeys: String, CodingKey {
            case abbreviation
            case duration
            case bloodGlucoseTarget = "bgTarget"
            case basalRateScaleFactor
            case carbohydrateRatioScaleFactor = "carbRatioScaleFactor"
            case insulinSensitivityScaleFactor
        }
    }

    public struct Units: Codable, Equatable {
        public typealias BloodGlucoseUnits = TBloodGlucose.Units
        public typealias CarbohydrateUnits = TCarbohydrate.Units
        public typealias InsulinUnits = TInsulin.Units
        
        public var bloodGlucose: BloodGlucoseUnits?
        public var carbohydrate: CarbohydrateUnits?
        public var insulin: InsulinUnits?
        
        public init(bloodGlucose: BloodGlucoseUnits? = nil, carbohydrate: CarbohydrateUnits? = nil, insulin: InsulinUnits? = nil) {
            self.bloodGlucose = bloodGlucose
            self.carbohydrate = carbohydrate
            self.insulin = insulin
        }
        
        private enum CodingKeys: String, CodingKey {
            case bloodGlucose = "bg"
            case carbohydrate = "carb"
            case insulin
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case activeScheduleName = "activeSchedule"
        case automatedDelivery
        case basal
        case basalRateSchedule = "basalSchedule"
        case basalRateSchedules = "basalSchedules"
        case bloodGlucoseSafetyLimit = "bgSafetyLimit"
        case bloodGlucoseTargetPhysicalActivity = "bgTargetPhysicalActivity"
        case bloodGlucoseTargetPreprandial = "bgTargetPreprandial"
        case bloodGlucoseTargetSchedule = "bgTarget"
        case bloodGlucoseTargetSchedules = "bgTargets"
        case bolus
        case carbohydrateRatioSchedule = "carbRatio"
        case carbohydrateRatioSchedules = "carbRatios"
        case display
        case firmwareVersion
        case hardwareVersion
        case insulinFormulation
        case insulinModel
        case insulinSensitivitySchedule = "insulinSensitivity"
        case insulinSensitivitySchedules = "insulinSensitivities"
        case manufacturers
        case model
        case name
        case overridePresets
        case scheduleTimeZoneOffset
        case serialNumber
        case softwareVersion
        case units
    }
}
