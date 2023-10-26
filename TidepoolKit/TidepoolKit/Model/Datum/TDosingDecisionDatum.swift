//
//  TDosingDecisionDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 3/6/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

public class TDosingDecisionDatum: TDatum, Decodable {
    public typealias BloodGlucoseStartTarget = TBloodGlucose.StartTarget
    public typealias Nutrition = TFoodDatum.Nutrition

    public var reason: String?
    public var originalFood: Food?
    public var food: Food?
    public var selfMonitoredBloodGlucose: BloodGlucose?
    public var carbohydratesOnBoard: CarbohydratesOnBoard?
    public var insulinOnBoard: InsulinOnBoard?
    public var bloodGlucoseTargetSchedule: [BloodGlucoseStartTarget]?
    public var historicalBloodGlucose: [BloodGlucose]?
    public var forecastBloodGlucose: [BloodGlucose]?
    public var recommendedBasal: RecommendedBasal?
    public var recommendedBolus: RecommendedBolus?
    public var requestedBolus: RequestedBolus?
    public var warnings: [Issue]?
    public var errors: [Issue]?
    public var scheduleTimeZoneOffset: TimeInterval?
    public var units: Units?

    public init(time: Date,
                reason: String,
                originalFood: Food? = nil,
                food: Food? = nil,
                selfMonitoredBloodGlucose: BloodGlucose? = nil,
                carbohydratesOnBoard: CarbohydratesOnBoard? = nil,
                insulinOnBoard: InsulinOnBoard? = nil,
                bloodGlucoseTargetSchedule: [BloodGlucoseStartTarget]? = nil,
                historicalBloodGlucose: [BloodGlucose]? = nil,
                forecastBloodGlucose: [BloodGlucose]? = nil,
                recommendedBasal: RecommendedBasal? = nil,
                recommendedBolus: RecommendedBolus? = nil,
                requestedBolus: RequestedBolus? = nil,
                warnings: [Issue]? = nil,
                errors: [Issue]? = nil,
                scheduleTimeZoneOffset: TimeInterval? = nil,
                units: Units) {
        self.reason = reason
        self.originalFood = originalFood
        self.food = food
        self.selfMonitoredBloodGlucose = selfMonitoredBloodGlucose
        self.carbohydratesOnBoard = carbohydratesOnBoard
        self.insulinOnBoard = insulinOnBoard
        self.bloodGlucoseTargetSchedule = bloodGlucoseTargetSchedule
        self.historicalBloodGlucose = historicalBloodGlucose
        self.forecastBloodGlucose = forecastBloodGlucose
        self.recommendedBasal = recommendedBasal
        self.recommendedBolus = recommendedBolus
        self.requestedBolus = requestedBolus
        self.warnings = warnings
        self.errors = errors
        self.scheduleTimeZoneOffset = scheduleTimeZoneOffset
        self.units = units
        super.init(.dosingDecision, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.originalFood = try container.decodeIfPresent(Food.self, forKey: .originalFood)
        self.food = try container.decodeIfPresent(Food.self, forKey: .food)
        self.selfMonitoredBloodGlucose = try container.decodeIfPresent(BloodGlucose.self, forKey: .selfMonitoredBloodGlucose)
        self.carbohydratesOnBoard = try container.decodeIfPresent(CarbohydratesOnBoard.self, forKey: .carbohydratesOnBoard)
        self.insulinOnBoard = try container.decodeIfPresent(InsulinOnBoard.self, forKey: .insulinOnBoard)
        self.bloodGlucoseTargetSchedule = try container.decodeIfPresent([BloodGlucoseStartTarget].self, forKey: .bloodGlucoseTargetSchedule)
        self.historicalBloodGlucose = try container.decodeIfPresent([BloodGlucose].self, forKey: .historicalBloodGlucose)
        self.forecastBloodGlucose = try container.decodeIfPresent([BloodGlucose].self, forKey: .forecastBloodGlucose)
        self.recommendedBasal = try container.decodeIfPresent(RecommendedBasal.self, forKey: .recommendedBasal)
        self.recommendedBolus = try container.decodeIfPresent(RecommendedBolus.self, forKey: .recommendedBolus)
        self.requestedBolus = try container.decodeIfPresent(RequestedBolus.self, forKey: .requestedBolus)
        self.warnings = try container.decodeIfPresent([Issue].self, forKey: .warnings)
        self.errors = try container.decodeIfPresent([Issue].self, forKey: .errors)
        self.scheduleTimeZoneOffset = try container.decodeIfPresent(Int.self, forKey: .scheduleTimeZoneOffset).map { .minutes($0) }
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        try super.init(.dosingDecision, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(originalFood, forKey: .originalFood)
        try container.encodeIfPresent(food, forKey: .food)
        try container.encodeIfPresent(selfMonitoredBloodGlucose, forKey: .selfMonitoredBloodGlucose)
        try container.encodeIfPresent(carbohydratesOnBoard, forKey: .carbohydratesOnBoard)
        try container.encodeIfPresent(insulinOnBoard, forKey: .insulinOnBoard)
        try container.encodeIfPresent(bloodGlucoseTargetSchedule, forKey: .bloodGlucoseTargetSchedule)
        try container.encodeIfPresent(historicalBloodGlucose, forKey: .historicalBloodGlucose)
        try container.encodeIfPresent(forecastBloodGlucose, forKey: .forecastBloodGlucose)
        try container.encodeIfPresent(recommendedBasal, forKey: .recommendedBasal)
        try container.encodeIfPresent(recommendedBolus, forKey: .recommendedBolus)
        try container.encodeIfPresent(requestedBolus, forKey: .requestedBolus)
        try container.encodeIfPresent(warnings, forKey: .warnings)
        try container.encodeIfPresent(errors, forKey: .errors)
        try container.encodeIfPresent(scheduleTimeZoneOffset.map { Int($0.minutes) }, forKey: .scheduleTimeZoneOffset)
        try container.encodeIfPresent(units, forKey: .units)
        try super.encode(to: encoder)
    }

    public struct Food: Codable, Equatable {
        public var time: Date?
        public var nutrition: Nutrition?

        public init(time: Date? = nil, nutrition: Nutrition) {
            self.time = time
            self.nutrition = nutrition
        }
    }

    public struct BloodGlucose: Codable, Equatable {
        public var time: Date?
        public var value: Double?

        public init(time: Date? = nil, value: Double) {
            self.time = time
            self.value = value
        }
    }

    public struct CarbohydratesOnBoard: Codable, Equatable {
        public var time: Date?
        public var amount: Double?

        public init(time: Date? = nil, amount: Double) {
            self.time = time
            self.amount = amount
        }
    }

    public struct InsulinOnBoard: Codable, Equatable {
        public var time: Date?
        public var amount: Double?

        public init(time: Date? = nil, amount: Double) {
            self.time = time
            self.amount = amount
        }
    }

    public struct RecommendedBasal: Codable, Equatable {
        public var rate: Double?
        public var duration: TimeInterval?

        public init(rate: Double, duration: TimeInterval) {
            self.rate = rate
            self.duration = duration
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
            self.duration = try container.decodeIfPresent(Int.self, forKey: .duration).map { .milliseconds($0) }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(rate, forKey: .rate)
            try container.encodeIfPresent(duration.map { Int($0.milliseconds) }, forKey: .duration)
        }

        private enum CodingKeys: String, CodingKey {
            case rate
            case duration
        }
    }

    public struct RecommendedBolus: Codable, Equatable {
        public var amount: Double?

        public init(amount: Double) {
            self.amount = amount
        }
    }

    public struct RequestedBolus: Codable, Equatable {
        public var amount: Double?

        public init(amount: Double) {
            self.amount = amount
        }
    }

    public struct Issue: Codable, Equatable {
        public let id: String
        public let metadata: TDictionary?

        public init(id: String, metadata: TDictionary? = nil) {
            self.id = id
            self.metadata = metadata?.isEmpty == false ? metadata : nil
        }
    }

    public struct Units: Codable, Equatable {
        public typealias BloodGlucoseUnits = TBloodGlucose.Units
        public typealias CarbohydrateUnits = TCarbohydrate.Units
        public typealias InsulinUnits = TInsulin.Units

        public var bloodGlucose: BloodGlucoseUnits?
        public var carbohydrate: CarbohydrateUnits?
        public var insulin: InsulinUnits?

        public init(bloodGlucose: BloodGlucoseUnits, carbohydrate: CarbohydrateUnits, insulin: InsulinUnits) {
            self.bloodGlucose = bloodGlucose
            self.carbohydrate = carbohydrate
            self.insulin = insulin
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.bloodGlucose = try container.decodeIfPresent(BloodGlucoseUnits.self, forKey: .bloodGlucose)
            self.carbohydrate = try container.decodeIfPresent(CarbohydrateUnits.self, forKey: .carbohydrate)
            self.insulin = try container.decodeIfPresent(InsulinUnits.self, forKey: .insulin)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(bloodGlucose, forKey: .bloodGlucose)
            try container.encodeIfPresent(carbohydrate, forKey: .carbohydrate)
            try container.encodeIfPresent(insulin, forKey: .insulin)
        }

        private enum CodingKeys: String, CodingKey {
            case bloodGlucose = "bg"
            case carbohydrate = "carb"
            case insulin
        }
    }

    private enum CodingKeys: String, CodingKey {
        case reason
        case originalFood
        case food
        case selfMonitoredBloodGlucose = "smbg"
        case carbohydratesOnBoard = "carbsOnBoard"
        case insulinOnBoard
        case bloodGlucoseTargetSchedule = "bgTargetSchedule"
        case historicalBloodGlucose = "bgHistorical"
        case forecastBloodGlucose = "bgForecast"
        case recommendedBasal
        case recommendedBolus
        case requestedBolus
        case warnings
        case errors
        case scheduleTimeZoneOffset
        case units
    }
}
