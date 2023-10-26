//
//  TReservoirChangeDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TReservoirChangeDeviceEventDatum: TDeviceEventDatum, Decodable {
    public var status: TStatusDeviceEventDatum?     // NOTE: API write only
    public var statusId: String?                    // NOTE: API read only

    public init(time: Date, status: TStatusDeviceEventDatum? = nil) {
        self.status = status
        super.init(.reservoirChange, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusId = try container.decodeIfPresent(String.self, forKey: .status)
        try super.init(.reservoirChange, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let status = status {
            try container.encodeIfPresent(status, forKey: .status)
        } else if let statusId = statusId {
            try container.encodeIfPresent(statusId, forKey: .status)
        }
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case status
    }
}
