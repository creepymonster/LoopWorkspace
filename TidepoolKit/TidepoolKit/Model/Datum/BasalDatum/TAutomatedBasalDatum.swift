//
//  TAutomatedBasalDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TAutomatedBasalDatum: TBasalDatum, Decodable {
    public typealias InsulinFormulation = TInsulinDatum.Formulation
    
    public var rate: Double?
    public var scheduleName: String?
    public var insulinFormulation: InsulinFormulation?
    public var suppressed: SuppressedBasal?

    public init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, rate: Double, scheduleName: String? = nil, insulinFormulation: InsulinFormulation? = nil) {
        self.rate = rate
        self.scheduleName = scheduleName
        self.insulinFormulation = insulinFormulation
        super.init(.automated, time: time, duration: duration, expectedDuration: expectedDuration)
    }

    public convenience init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, rate: Double, scheduleName: String? = nil, insulinFormulation: InsulinFormulation? = nil, suppressed: TScheduledBasalDatum.Suppressed) {
        self.init(time: time, duration: duration, expectedDuration: expectedDuration, rate: rate, scheduleName: scheduleName, insulinFormulation: insulinFormulation)
        self.suppressed = suppressed
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        self.scheduleName = try container.decodeIfPresent(String.self, forKey: .scheduleName)
        self.insulinFormulation = try container.decodeIfPresent(InsulinFormulation.self, forKey: .insulinFormulation)
        if container.contains(.suppressed) {
            let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .suppressed)
            let deliveryType = try nestedContainer.decode(TBasalDatum.DeliveryType.self, forKey: .deliveryType)
            switch deliveryType {
            case .scheduled:
                self.suppressed = try container.decode(TScheduledBasalDatum.Suppressed.self, forKey: .suppressed)
            default:
                throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: nestedContainer, debugDescription: "Unexpected deliveryType '\(deliveryType)'")
            }
        }
        try super.init(.automated, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(scheduleName, forKey: .scheduleName)
        try container.encodeIfPresent(insulinFormulation, forKey: .insulinFormulation)
        try container.encodeIfPresent(suppressed, forKey: .suppressed)
        try super.encode(to: encoder)
    }

    public class Suppressed: SuppressedBasal, Decodable {
        public var rate: Double?
        public var scheduleName: String?
        public var suppressed: SuppressedBasal?

        public init(rate: Double, scheduleName: String? = nil, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil) {
            self.rate = rate
            self.scheduleName = scheduleName
            super.init(.automated, insulinFormulation: insulinFormulation, annotations: annotations)
        }

        public convenience init(rate: Double, scheduleName: String? = nil, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil, suppressed: TScheduledBasalDatum.Suppressed) {
            self.init(rate: rate, scheduleName: scheduleName, insulinFormulation: insulinFormulation, annotations: annotations)
            self.suppressed = suppressed
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: SuppressedCodingKeys.self)
            self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
            self.scheduleName = try container.decodeIfPresent(String.self, forKey: .scheduleName)
            if container.contains(.suppressed) {
                let nestedContainer = try container.nestedContainer(keyedBy: SuppressedCodingKeys.self, forKey: .suppressed)
                let deliveryType = try nestedContainer.decode(TBasalDatum.DeliveryType.self, forKey: .deliveryType)
                switch deliveryType {
                case .scheduled:
                    self.suppressed = try container.decode(TScheduledBasalDatum.Suppressed.self, forKey: .suppressed)
                default:
                    throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: nestedContainer, debugDescription: "Unexpected deliveryType '\(deliveryType)'")
                }
            }
            try super.init(.automated, from: decoder)
        }

        public override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: SuppressedCodingKeys.self)
            try container.encodeIfPresent(rate, forKey: .rate)
            try container.encodeIfPresent(scheduleName, forKey: .scheduleName)
            try container.encodeIfPresent(suppressed, forKey: .suppressed)
            try super.encode(to: encoder)
        }

        private enum SuppressedCodingKeys: String, CodingKey {
            case deliveryType
            case rate
            case scheduleName
            case suppressed
        }
    }

    private enum CodingKeys: String, CodingKey {
        case deliveryType
        case rate
        case scheduleName
        case insulinFormulation
        case suppressed
    }
}
