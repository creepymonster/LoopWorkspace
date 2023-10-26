//
//  TSMBGDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 10/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TSMBGDatum: TDatum, Decodable {
    public typealias Units = TBloodGlucose.Units

    public enum SubType: String, Codable {
        case linked
        case manual
        case scanned
    }

    public var value: Double?
    public var units: Units?
    public var subType: SubType?

    public init(time: Date, value: Double, units: Units, subType: SubType? = nil) {
        self.value = value
        self.units = units
        self.subType = subType
        super.init(.smbg, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decodeIfPresent(Double.self, forKey: .value)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        self.subType = try container.decodeIfPresent(SubType.self, forKey: .subType)
        try super.init(.smbg, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(subType, forKey: .subType)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case value
        case units
        case subType
    }
}
