//
//  TWaterDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TWaterDatum: TDatum, Decodable {
    public var amount: Amount?

    public init(time: Date, amount: Amount) {
        self.amount = amount
        super.init(.water, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decodeIfPresent(Amount.self, forKey: .amount)
        try super.init(.water, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(amount, forKey: .amount)
        try super.encode(to: encoder)
    }

    public struct Amount: Codable, Equatable {
        public enum Units: String, Codable {
            case milliliters
            case ounces
            case liters
            case gallons
        }

        public var value: Double?
        public var units: Units?

        public init(_ value: Double, _ units: Units) {
            self.value = value
            self.units = units
        }
    }

    private enum CodingKeys: String, CodingKey {
        case amount
    }
}
