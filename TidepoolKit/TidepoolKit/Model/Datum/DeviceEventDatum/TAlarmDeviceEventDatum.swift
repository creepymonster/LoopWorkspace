//
//  TAlarmDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TAlarmDeviceEventDatum: TDeviceEventDatum, Decodable {
    public enum AlarmType: String, Codable {
        case autoOff = "auto_off"
        case lowInsulin = "low_insulin"
        case lowPower = "low_power"
        case noDelivery = "no_delivery"
        case noInsulin = "no_insulin"
        case noPower = "no_power"
        case occlusion
        case other
        case overLimit = "over_limit"
    }

    public var alarmType: AlarmType?
    public var status: TStatusDeviceEventDatum?     // NOTE: API write only
    public var statusId: String?                    // NOTE: API read only

    public init(time: Date, alarmType: AlarmType, status: TStatusDeviceEventDatum? = nil) {
        self.alarmType = alarmType
        self.status = status
        super.init(.alarm, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.alarmType = try container.decodeIfPresent(AlarmType.self, forKey: .alarmType)
        self.statusId = try container.decodeIfPresent(String.self, forKey: .status)
        try super.init(.alarm, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(alarmType, forKey: .alarmType)
        if let status = status {
            try container.encodeIfPresent(status, forKey: .status)
        } else if let statusId = statusId {
            try container.encodeIfPresent(statusId, forKey: .status)
        }
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case alarmType
        case status
    }
}
