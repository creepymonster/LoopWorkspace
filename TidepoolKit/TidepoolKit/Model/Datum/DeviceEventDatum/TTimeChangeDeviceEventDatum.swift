//
//  TTimeChangeDeviceEventDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TTimeChangeDeviceEventDatum: TDeviceEventDatum, Decodable {
    public enum Method: String, Codable {
        case automatic
        case manual
    }

    public var from: Info?
    public var to: Info?
    public var method: Method?
    public var change: Change?  // DEPRECATED

    public init(time: Date, from: Info, to: Info, method: Method? = nil) {
        self.from = from
        self.to = to
        self.method = method
        super.init(.timeChange, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.from = try container.decodeIfPresent(Info.self, forKey: .from)
        self.to = try container.decodeIfPresent(Info.self, forKey: .to)
        self.method = try container.decodeIfPresent(Method.self, forKey: .method)
        self.change = try container.decodeIfPresent(Change.self, forKey: .change)
        try super.init(.timeChange, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(from, forKey: .from)
        try container.encodeIfPresent(to, forKey: .to)
        try container.encodeIfPresent(method, forKey: .method)
        try container.encodeIfPresent(change, forKey: .change)
        try super.encode(to: encoder)
    }

    public struct Info: Codable, Equatable {
        public var time: String?
        public var timeZoneName: String?

        public init(time: String? = nil, timeZoneName: String? = nil) {
            self.time = time
            self.timeZoneName = timeZoneName
        }
    }

    // DEPRECATED
    public struct Change: Codable, Equatable {
        public enum Agent: String, Codable {
            case automatic
            case manual
        }

        public var from: String?
        public var to: String?
        public var agent: Agent?

        public init(from: String? = nil, to: String? = nil, agent: Agent? = nil) {
            self.from = from
            self.to = to
            self.agent = agent
        }
    }

    private enum CodingKeys: String, CodingKey {
        case from
        case to
        case method
        case change  // DEPRECATED
    }
}
