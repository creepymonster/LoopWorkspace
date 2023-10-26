//
//  TExtendedBolusDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/30/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TExtendedBolusDatum: TBolusDatum, Decodable {
    public var extended: Double?
    public var expectedExtended: Double?
    public var duration: TimeInterval?
    public var expectedDuration: TimeInterval?

    public init(time: Date, extended: Double, expectedExtended: Double? = nil, duration: TimeInterval, expectedDuration: TimeInterval? = nil, insulinFormulation: InsulinFormulation? = nil) {
        self.extended = extended
        self.expectedExtended = expectedExtended
        self.duration = duration
        self.expectedDuration = expectedDuration
        super.init(.extended, time: time, insulinFormulation: insulinFormulation)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.extended = try container.decodeIfPresent(Double.self, forKey: .extended)
        self.expectedExtended = try container.decodeIfPresent(Double.self, forKey: .expectedExtended)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration).map { .milliseconds($0) }
        self.expectedDuration = try container.decodeIfPresent(Int.self, forKey: .expectedDuration).map { .milliseconds($0) }
        try super.init(.extended, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(extended, forKey: .extended)
        try container.encodeIfPresent(expectedExtended, forKey: .expectedExtended)
        try container.encodeIfPresent(duration.map { Int($0.milliseconds) }, forKey: .duration)
        try container.encodeIfPresent(expectedDuration.map { Int($0.milliseconds) }, forKey: .expectedDuration)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case extended
        case expectedExtended
        case duration
        case expectedDuration
    }
}
