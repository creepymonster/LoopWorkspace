//
//  TCBGDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/23/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TCBGDatum: TDatum, Decodable {
    public typealias Units = TBloodGlucose.Units
    public typealias Trend = TBloodGlucose.Trend

    public var value: Double?
    public var units: Units?
    public var trend: Trend?
    public var trendRate: Double?

    public init(time: Date, value: Double, units: Units, trend: Trend? = nil, trendRate: Double? = nil) {
        self.value = value
        self.units = units
        self.trend = trend
        self.trendRate = trendRate
        super.init(.cbg, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decodeIfPresent(Double.self, forKey: .value)
        self.units = try container.decodeIfPresent(Units.self, forKey: .units)
        self.trend = try container.decodeIfPresent(Trend.self, forKey: .trend)
        self.trendRate = try container.decodeIfPresent(Double.self, forKey: .trendRate)
        try super.init(.cbg, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encodeIfPresent(units, forKey: .units)
        try container.encodeIfPresent(trend, forKey: .trend)
        try container.encodeIfPresent(trendRate, forKey: .trendRate)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case value
        case units
        case trend
        case trendRate
    }
}
