//
//  TCalculatorDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TCalculatorDatum: TDatum, Decodable {
    public typealias BloodGlucoseTarget = TBloodGlucose.Target
    public typealias Units = TBloodGlucose.Units

    public var insulinOnBoard: Double?
    public var bloodGlucoseInput: Double?
    public var insulinSensitivity: Double?
    public var carbohydrateInput: Double?
    public var insulinCarbohydrateRatio: Double?
    public var bloodGlucoseTarget: BloodGlucoseTarget?
    public var recommended: Recommended?
    public var bolus: TBolusDatum?      // NOTE: API write only
    public var bolusId: String?         // NOTE: API read only
    public var units: Units?

    public init(time: Date, insulinOnBoard: Double? = nil, bloodGlucoseInput: Double? = nil, insulinSensitivity: Double? = nil, carbohydrateInput: Double? = nil, insulinCarbohydrateRatio: Double? = nil, bloodGlucoseTarget: BloodGlucoseTarget? = nil, recommended: Recommended? = nil, bolus: TBolusDatum? = nil, units: Units? = nil) {
        self.insulinOnBoard = insulinOnBoard
        self.bloodGlucoseInput = bloodGlucoseInput
        self.insulinSensitivity = insulinSensitivity
        self.carbohydrateInput = carbohydrateInput
        self.insulinCarbohydrateRatio = insulinCarbohydrateRatio
        self.bloodGlucoseTarget = bloodGlucoseTarget
        self.recommended = recommended
        self.bolus = bolus
        self.units = units
        super.init(.calculator, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.insulinOnBoard = try container.decodeIfPresent(Double.self, forKey: .insulinOnBoard)
        self.bloodGlucoseInput = try container.decodeIfPresent(Double.self, forKey: .bloodGlucoseInput)
        self.insulinSensitivity = try container.decodeIfPresent(Double.self, forKey: .insulinSensitivity)
        self.carbohydrateInput = try container.decodeIfPresent(Double.self, forKey: .carbohydrateInput)
        self.insulinCarbohydrateRatio = try container.decodeIfPresent(Double.self, forKey: .insulinCarbohydrateRatio)
        self.bloodGlucoseTarget = try container.decodeIfPresent(BloodGlucoseTarget.self, forKey: .bloodGlucoseTarget)
        self.recommended = try container.decodeIfPresent(Recommended.self, forKey: .recommended)
        self.bolusId = try container.decodeIfPresent(String.self, forKey: .bolus)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        try super.init(.calculator, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(insulinOnBoard, forKey: .insulinOnBoard)
        try container.encodeIfPresent(bloodGlucoseInput, forKey: .bloodGlucoseInput)
        try container.encodeIfPresent(insulinSensitivity, forKey: .insulinSensitivity)
        try container.encodeIfPresent(carbohydrateInput, forKey: .carbohydrateInput)
        try container.encodeIfPresent(insulinCarbohydrateRatio, forKey: .insulinCarbohydrateRatio)
        try container.encodeIfPresent(bloodGlucoseTarget, forKey: .bloodGlucoseTarget)
        try container.encodeIfPresent(recommended, forKey: .recommended)
        if let bolus = bolus {
            try container.encodeIfPresent(bolus, forKey: .bolus)
        } else if let bolusId = bolusId {
            try container.encodeIfPresent(bolusId, forKey: .bolus)
        }
        try container.encodeIfPresent(units, forKey: .units)
        try super.encode(to: encoder)
    }

    public struct Recommended: Codable, Equatable {
        public var net: Double?
        public var carbohydrate: Double?
        public var correction: Double?

        public init(net: Double? = nil, carbohydrate: Double? = nil, correction: Double? = nil) {
            self.net = net
            self.carbohydrate = carbohydrate
            self.correction = correction
        }

        private enum CodingKeys: String, CodingKey {
            case net
            case carbohydrate = "carb"
            case correction
        }
    }

    private enum CodingKeys: String, CodingKey {
        case insulinOnBoard
        case bloodGlucoseInput = "bgInput"
        case insulinSensitivity
        case carbohydrateInput = "carbInput"
        case insulinCarbohydrateRatio = "insulinCarbRatio"
        case bloodGlucoseTarget = "bgTarget"
        case recommended
        case bolus
        case units
    }
}
