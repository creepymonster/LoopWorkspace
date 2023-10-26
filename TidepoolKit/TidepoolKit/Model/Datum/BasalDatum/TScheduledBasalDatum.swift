//
//  TScheduledBasalDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TScheduledBasalDatum: TBasalDatum, Decodable {
    public typealias InsulinFormulation = TInsulinDatum.Formulation
    
    public var rate: Double?
    public var scheduleName: String?
    public var insulinFormulation: InsulinFormulation?
    
    public init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, rate: Double, scheduleName: String? = nil, insulinFormulation: InsulinFormulation? = nil) {
        self.rate = rate
        self.scheduleName = scheduleName
        self.insulinFormulation = insulinFormulation
        super.init(.scheduled, time: time, duration: duration, expectedDuration: expectedDuration)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        self.scheduleName = try container.decodeIfPresent(String.self, forKey: .scheduleName)
        self.insulinFormulation = try container.decodeIfPresent(InsulinFormulation.self, forKey: .insulinFormulation)
        try super.init(.scheduled, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(scheduleName, forKey: .scheduleName)
        try container.encodeIfPresent(insulinFormulation, forKey: .insulinFormulation)
        try super.encode(to: encoder)
    }

    public class Suppressed: SuppressedBasal, Decodable {
        public var rate: Double?
        public var scheduleName: String?

        public init(rate: Double, scheduleName: String? = nil, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil) {
            self.rate = rate
            self.scheduleName = scheduleName
            super.init(.scheduled, insulinFormulation: insulinFormulation, annotations: annotations)
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: SuppressedCodingKeys.self)
            self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
            self.scheduleName = try container.decodeIfPresent(String.self, forKey: .scheduleName)
            try super.init(.scheduled, from: decoder)
        }

        public override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: SuppressedCodingKeys.self)
            try container.encodeIfPresent(rate, forKey: .rate)
            try container.encodeIfPresent(scheduleName, forKey: .scheduleName)
            try super.encode(to: encoder)
        }

        private enum SuppressedCodingKeys: String, CodingKey {
            case rate
            case scheduleName
        }
    }

    private enum CodingKeys: String, CodingKey {
        case rate
        case scheduleName
        case insulinFormulation
    }
}
