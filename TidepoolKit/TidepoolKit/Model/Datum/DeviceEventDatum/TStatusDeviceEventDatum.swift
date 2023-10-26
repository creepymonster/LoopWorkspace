//
//  TStatusDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TStatusDeviceEventDatum: TDeviceEventDatum, Decodable {
    public enum Name: String, Codable {
        case resumed
        case suspended
    }

    public var name: Name?
    public var duration: TimeInterval?
    public var expectedDuration: TimeInterval?
    public var reason: TDictionary?

    public init(time: Date, name: Name? = nil, duration: TimeInterval? = nil, expectedDuration: TimeInterval? = nil, reason: TDictionary? = nil) {
        self.name = name
        self.duration = duration
        self.expectedDuration = expectedDuration
        self.reason = reason
        super.init(.status, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(Name.self, forKey: .name)
        self.duration = try container.decodeIfPresent(Int.self, forKey: .duration).map { .milliseconds($0) }
        self.expectedDuration = try container.decodeIfPresent(Int.self, forKey: .expectedDuration).map { .milliseconds($0) }
        self.reason = try container.decodeIfPresent(TDictionary.self, forKey: .reason)
        try super.init(.status, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(duration.map { Int($0.milliseconds) }, forKey: .duration)
        try container.encodeIfPresent(expectedDuration.map { Int($0.milliseconds) }, forKey: .expectedDuration)
        try container.encodeIfPresent(reason, forKey: .reason)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case name = "status"
        case duration
        case expectedDuration
        case reason
    }
}
