//
//  TInsulinDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TInsulinDatum: TDatum, Decodable {
    public var dose: Dose?
    public var formulation: Formulation?
    public var site: String?

    public init(time: Date, dose: Dose, formulation: Formulation? = nil, site: String? = nil) {
        self.dose = dose
        self.formulation = formulation
        self.site = site
        super.init(.insulin, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dose = try container.decodeIfPresent(Dose.self, forKey: .dose)
        self.formulation = try container.decodeIfPresent(Formulation.self, forKey: .formulation)
        self.site = try container.decodeIfPresent(String.self, forKey: .site)
        try super.init(.insulin, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(dose, forKey: .dose)
        try container.encodeIfPresent(formulation, forKey: .formulation)
        try container.encodeIfPresent(site, forKey: .site)
        try super.encode(to: encoder)
    }

    public struct Dose: Codable, Equatable {
        public typealias Units = TInsulin.Units

        public var active: Double?
        public var correction: Double?
        public var food: Double?
        public var total: Double?
        public var units: Units?

        public init(active: Double? = nil, correction: Double? = nil, food: Double? = nil, total: Double? = nil, units: Units = .units) {
            self.active = active
            self.correction = correction
            self.food = food
            self.total = total
            self.units = units
        }
    }

    public struct Formulation: Codable, Equatable {
        public var name: String?
        public var simple: Simple?
        public var compounds: [Compound]?

        public init(name: String? = nil, simple: Simple? = nil, compounds: [Compound]? = nil) {
            self.name = name
            self.simple = simple
            self.compounds = compounds
        }

        public struct Simple: Codable, Equatable {
            public enum ActingType: String, Codable {
                case rapid
                case short
                case intermediate
                case long
            }

            public var actingType: ActingType?
            public var brand: String?
            public var concentration: Concentration?

            public init(actingType: ActingType? = nil, brand: String? = nil, concentration: Concentration? = nil) {
                self.actingType = actingType
                self.brand = brand
                self.concentration = concentration
            }

            public struct Concentration: Codable, Equatable {
                public enum Units: String, Codable {
                    case unitsPerML = "Units/mL"
                }

                public var value: Double?
                public var units: Units?

                public init(_ value: Double, _ units: Units = .unitsPerML) {
                    self.value = value
                    self.units = units
                }
            }
        }

        public struct Compound: Codable, Equatable {
            public var amount: Double?
            public var formulation: Formulation?

            public init(amount: Double, formulation: Formulation) {
                self.amount = amount
                self.formulation = formulation
            }
        }
    }

    private enum CodingKeys: String, CodingKey {
        case dose
        case formulation
        case site
    }
}
