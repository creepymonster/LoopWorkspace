//
//  TControllerStatusDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 10/27/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import Foundation

public class TControllerStatusDatum: TDatum, Decodable {
    public var battery: Battery?

    public init(time: Date, battery: Battery? = nil) {
        self.battery = battery
        super.init(.controllerStatus, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.battery = try container.decodeIfPresent(Battery.self, forKey: .battery)
        try super.init(.controllerStatus, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(battery, forKey: .battery)
        try super.encode(to: encoder)
    }

    public struct Battery: Codable, Equatable {
        public enum State: String, Codable {
            case unplugged
            case charging
            case full
        }

        public enum Units: String, Codable {
            case percent
        }

        public var time: Date?
        public var state: State?
        public var remaining: Double?
        public var units: Units?

        public init(time: Date? = nil, state: State? = nil, remaining: Double? = nil, units: Units? = nil) {
            self.time = time
            self.state = state
            self.remaining = remaining
            self.units = units
        }
    }

    private enum CodingKeys: String, CodingKey {
        case battery
    }
}
