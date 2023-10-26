//
//  TTemporaryBasalDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TTemporaryBasalDatum: TBasalDatum, Decodable {
    public typealias InsulinFormulation = TInsulinDatum.Formulation
    
    public var rate: Double?
    public var percent: Double?
    public var insulinFormulation: InsulinFormulation?
    public var suppressed: SuppressedBasal?
    
    public init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, rate: Double, percent: Double? = nil, insulinFormulation: InsulinFormulation? = nil) {
        self.rate = rate
        self.percent = percent
        self.insulinFormulation = insulinFormulation
        super.init(.temporary, time: time, duration: duration, expectedDuration: expectedDuration)
    }

    public convenience init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, rate: Double, percent: Double? = nil, insulinFormulation: InsulinFormulation? = nil, suppressed: TAutomatedBasalDatum.Suppressed) {
        self.init(time: time, duration: duration, expectedDuration: expectedDuration, rate: rate, percent: percent, insulinFormulation: insulinFormulation)
        self.suppressed = suppressed
    }

    public convenience init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, rate: Double, percent: Double? = nil, insulinFormulation: InsulinFormulation? = nil, suppressed: TScheduledBasalDatum.Suppressed) {
        self.init(time: time, duration: duration, expectedDuration: expectedDuration, rate: rate, percent: percent, insulinFormulation: insulinFormulation)
        self.suppressed = suppressed
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        self.percent = try container.decodeIfPresent(Double.self, forKey: .percent)
        self.insulinFormulation = try container.decodeIfPresent(InsulinFormulation.self, forKey: .insulinFormulation)
        if container.contains(.suppressed) {
            let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .suppressed)
            let deliveryType = try nestedContainer.decode(TBasalDatum.DeliveryType.self, forKey: .deliveryType)
            switch deliveryType {
            case .automated:
                self.suppressed = try container.decode(TAutomatedBasalDatum.Suppressed.self, forKey: .suppressed)
            case .scheduled:
                self.suppressed = try container.decode(TScheduledBasalDatum.Suppressed.self, forKey: .suppressed)
            default:
                throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: nestedContainer, debugDescription: "Unexpected deliveryType '\(deliveryType)'")
            }
        }
        try super.init(.temporary, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(rate, forKey: .rate)
        try container.encodeIfPresent(percent, forKey: .percent)
        try container.encodeIfPresent(insulinFormulation, forKey: .insulinFormulation)
        try container.encodeIfPresent(suppressed, forKey: .suppressed)
        try super.encode(to: encoder)
    }

    public class Suppressed: SuppressedBasal, Decodable {
        public var rate: Double?
        public var percent: Double?
        public var suppressed: SuppressedBasal?
        
        public init(rate: Double, percent: Double? = nil, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil) {
            self.rate = rate
            self.percent = percent
            super.init(.temporary, insulinFormulation: insulinFormulation, annotations: annotations)
        }

        public convenience init(rate: Double, percent: Double? = nil, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil, suppressed: TAutomatedBasalDatum.Suppressed) {
            self.init(rate: rate, percent: percent, insulinFormulation: insulinFormulation, annotations: annotations)
            self.suppressed = suppressed
        }

        public convenience init(rate: Double, percent: Double? = nil, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil, suppressed: TScheduledBasalDatum.Suppressed) {
            self.init(rate: rate, percent: percent, insulinFormulation: insulinFormulation, annotations: annotations)
            self.suppressed = suppressed
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: SuppressedCodingKeys.self)
            self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
            self.percent = try container.decodeIfPresent(Double.self, forKey: .percent)
            if container.contains(.suppressed) {
                let nestedContainer = try container.nestedContainer(keyedBy: SuppressedCodingKeys.self, forKey: .suppressed)
                let deliveryType = try nestedContainer.decode(TBasalDatum.DeliveryType.self, forKey: .deliveryType)
                switch deliveryType {
                case .automated:
                    self.suppressed = try container.decode(TAutomatedBasalDatum.Suppressed.self, forKey: .suppressed)
                case .scheduled:
                    self.suppressed = try container.decode(TScheduledBasalDatum.Suppressed.self, forKey: .suppressed)
                default:
                    throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: nestedContainer, debugDescription: "Unexpected deliveryType '\(deliveryType)'")
                }
            }
            try super.init(.temporary, from: decoder)
        }

        public override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: SuppressedCodingKeys.self)
            try container.encodeIfPresent(rate, forKey: .rate)
            try container.encodeIfPresent(percent, forKey: .percent)
            try container.encodeIfPresent(suppressed, forKey: .suppressed)
            try super.encode(to: encoder)
        }

        private enum SuppressedCodingKeys: String, CodingKey {
            case deliveryType
            case rate
            case percent
            case suppressed
        }
    }

    private enum CodingKeys: String, CodingKey {
        case deliveryType
        case rate
        case percent
        case insulinFormulation
        case suppressed
    }
}
