//
//  TBolusDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/30/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TBolusDatum: TDatum {
    public typealias InsulinFormulation = TInsulinDatum.Formulation

    public enum SubType: String, Codable {
        case automated
        case combination = "dual/square"
        case extended = "square"
        case normal
    }

    public let subType: SubType
    public var insulinFormulation: InsulinFormulation?

    public init(_ subType: SubType, time: Date, insulinFormulation: InsulinFormulation? = nil) {
        self.subType = subType
        self.insulinFormulation = insulinFormulation
        super.init(.bolus, time: time)
    }

    public init(_ expectedSubType: SubType, from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.subType = try container.decode(SubType.self, forKey: .subType)
        guard self.subType == expectedSubType else {
            throw DecodingError.dataCorruptedError(forKey: .subType, in: container, debugDescription: "Unexpected subType '\(self.subType)'")
        }
        self.insulinFormulation = try container.decodeIfPresent(InsulinFormulation.self, forKey: .insulinFormulation)
        try super.init(.bolus, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subType, forKey: .subType)
        try container.encodeIfPresent(insulinFormulation, forKey: .insulinFormulation)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case subType
        case insulinFormulation
    }
}
