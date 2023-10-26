//
//  TSuspendedBasalDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TSuspendedBasalDatum: TBasalDatum, Decodable {
    public var suppressed: SuppressedBasal?

    public init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil) {
        super.init(.suspended, time: time, duration: duration, expectedDuration: expectedDuration)
    }
    
    public convenience init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, suppressed: TAutomatedBasalDatum.Suppressed) {
        self.init(time: time, duration: duration, expectedDuration: expectedDuration)
        self.suppressed = suppressed
    }

    public convenience init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, suppressed: TScheduledBasalDatum.Suppressed) {
        self.init(time: time, duration: duration, expectedDuration: expectedDuration)
        self.suppressed = suppressed
    }

    public convenience init(time: Date, duration: TimeInterval, expectedDuration: TimeInterval? = nil, suppressed: TTemporaryBasalDatum.Suppressed) {
        self.init(time: time, duration: duration, expectedDuration: expectedDuration)
        self.suppressed = suppressed
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.suppressed) {
            let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .suppressed)
            let deliveryType = try nestedContainer.decode(TBasalDatum.DeliveryType.self, forKey: .deliveryType)
            switch deliveryType {
            case .automated:
                self.suppressed = try container.decode(TAutomatedBasalDatum.Suppressed.self, forKey: .suppressed)
            case .scheduled:
                self.suppressed = try container.decode(TScheduledBasalDatum.Suppressed.self, forKey: .suppressed)
            case .temporary:
                self.suppressed = try container.decode(TTemporaryBasalDatum.Suppressed.self, forKey: .suppressed)
            default:
                throw DecodingError.dataCorruptedError(forKey: .deliveryType, in: nestedContainer, debugDescription: "Unexpected deliveryType '\(deliveryType)'")
            }
        }
        try super.init(.suspended, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(suppressed, forKey: .suppressed)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case deliveryType
        case suppressed
    }
}
