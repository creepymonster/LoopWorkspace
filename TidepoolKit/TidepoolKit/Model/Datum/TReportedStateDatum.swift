//
//  TReportedStateDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/1/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TReportedStateDatum: TDatum, Decodable {
    public var states: [State]?

    public init(time: Date, states: [State]) {
        self.states = states
        super.init(.reportedState, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.states = try container.decodeIfPresent([State].self, forKey: .states)
        try super.init(.reportedState, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(states, forKey: .states)
        try super.encode(to: encoder)
    }

    public struct State: Codable, Equatable {
        public enum State: String, Codable {
            case alcohol
            case cycle
            case hyperglycemiaSymptoms
            case hypoglycemiaSymptoms
            case illness
            case other
            case stress
        }

        public var state: State?
        public var stateOther: String?
        public var severity: Int?

        public init(_ state: State, stateOther: String? = nil, severity: Int? = nil) {
            self.state = state
            self.stateOther = stateOther
            self.severity = severity
        }
    }

    private enum CodingKeys: String, CodingKey {
        case states
    }
}
