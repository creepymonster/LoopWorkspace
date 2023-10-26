//
//  TBasalDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/23/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TBasalDatum: TDatum {
    public enum DeliveryType: String, Codable {
        case automated
        case scheduled
        case suspended = "suspend"
        case temporary = "temp"
    }
    
    public let deliveryType: DeliveryType
    public var duration: TimeInterval?
    public var expectedDuration: TimeInterval?
    
    public init(_ deliveryType: DeliveryType, time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil) {
        self.deliveryType = deliveryType
        self.duration = duration
        self.expectedDuration = expectedDuration
        super.init(.basal, time: time)
    }

    public init(_ expectedDeliveryType: DeliveryType, from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.deliveryType = try container.decode(DeliveryType.self, forKey: .deliveryType)
        guard self.deliveryType == expectedDeliveryType else {
            throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: container, debugDescription: "Unexpected deliveryType '\(self.deliveryType)'")
        }
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration).map { .milliseconds($0) }
        self.expectedDuration = try container.decodeIfPresent(Int.self, forKey: .expectedDuration).map { .milliseconds($0) }
        try super.init(.basal, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deliveryType, forKey: .deliveryType)
        try container.encodeIfPresent(duration.map { Int($0.milliseconds) }, forKey: .duration)
        try container.encodeIfPresent(expectedDuration.map { Int($0.milliseconds) }, forKey: .expectedDuration)
        try super.encode(to: encoder)
    }

    public class SuppressedBasal: Encodable {
        public typealias DatumType = TDatum.DatumType
        public typealias InsulinFormulation = TInsulinDatum.Formulation
        
        public let type: DatumType
        public let deliveryType: DeliveryType
        public var insulinFormulation: InsulinFormulation?
        public var annotations: [TDictionary]?
        
        public init(_ deliveryType: DeliveryType, insulinFormulation: InsulinFormulation? = nil, annotations: [TDictionary]? = nil) {
            self.type = .basal
            self.deliveryType = deliveryType
            self.annotations = annotations
            self.insulinFormulation = insulinFormulation
        }

        public init(_ expectedDeliveryType: DeliveryType, from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(DatumType.self, forKey: .type)
            guard self.type == .basal else {
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unexpected type '\(self.type)'")
            }
            self.deliveryType = try container.decode(DeliveryType.self, forKey: .deliveryType)
            guard self.deliveryType == expectedDeliveryType else {
                throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: container, debugDescription: "Unexpected deliveryType '\(self.deliveryType)'")
            }
            self.insulinFormulation = try container.decodeIfPresent(InsulinFormulation.self, forKey: .insulinFormulation)
            self.annotations = try container.decodeIfPresent([TDictionary].self, forKey: .annotations)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(type, forKey: .type)
            try container.encode(deliveryType, forKey: .deliveryType)
            try container.encodeIfPresent(insulinFormulation, forKey: .insulinFormulation)
            try container.encodeIfPresent(annotations, forKey: .annotations)
        }

        private enum CodingKeys: String, CodingKey {
            case type
            case deliveryType
            case insulinFormulation
            case annotations
        }
    }

    private enum CodingKeys: String, CodingKey {
        case deliveryType
        case duration
        case expectedDuration
    }
}
