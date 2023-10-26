//
//  TPrimeDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TPrimeDeviceEventDatum: TDeviceEventDatum, Decodable {
    public enum Target: String, Codable {
        case cannula
        case tubing
    }

    public var volume: Double?
    public var target: Target?

    public init(time: Date, volume: Double? = nil, target: Target? = nil) {
        self.volume = volume
        self.target = target
        super.init(.prime, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.volume = try container.decodeIfPresent(Double.self, forKey: .volume)
        self.target = try container.decodeIfPresent(Target.self, forKey: .target)
        try super.init(.prime, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(volume, forKey: .volume)
        try container.encodeIfPresent(target, forKey: .target)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case volume
        case target = "primeTarget"
    }
}
