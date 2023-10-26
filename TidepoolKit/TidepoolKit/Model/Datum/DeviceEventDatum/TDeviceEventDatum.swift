//
//  TDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TDeviceEventDatum: TDatum {
    public enum SubType: String, Codable {
        case alarm
        case calibration
        case prime
        case pumpSettingsOverride
        case reservoirChange
        case status
        case timeChange
    }

    public let subType: SubType

    public init(_ subType: SubType, time: Date) {
        self.subType = subType
        super.init(.deviceEvent, time: time)
    }

    public init(_ expectedSubType: SubType, from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.subType = try container.decode(SubType.self, forKey: .subType)
        guard self.subType == expectedSubType else {
            throw DecodingError.dataCorruptedError(forKey: .subType, in: container, debugDescription: "Unexpected subType '\(self.subType)'")
        }
        try super.init(.deviceEvent, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(subType, forKey: .subType)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case subType
    }
}
