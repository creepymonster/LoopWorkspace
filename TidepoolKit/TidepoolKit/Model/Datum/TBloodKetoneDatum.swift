//
//  TBloodKetoneDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 10/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TBloodKetoneDatum: TDatum, Decodable {
    public enum Units: String, Codable {
        case millimolesPerLiter = "mmol/L"
    }

    public var value: Double?
    public var units: Units?

    public init(time: Date, value: Double, units: Units = .millimolesPerLiter) {
        self.value = value
        self.units = units
        super.init(.bloodKetone, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decodeIfPresent(Double.self, forKey: .value)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        try super.init(.bloodKetone, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encodeIfPresent(units, forKey: .units)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case value
        case units
    }
}
