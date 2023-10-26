//
//  TPumpStatus.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 3/6/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

public class TPumpStatusDatum: TDatum, Decodable {
    public var basalDelivery: BasalDelivery?
    public var battery: Battery?
    public var bolusDelivery: BolusDelivery?
    public var deliveryIndeterminant: Bool?
    public var reservoir: Reservoir?

    public init(time: Date,
                basalDelivery: BasalDelivery? = nil,
                battery: Battery? = nil,
                bolusDelivery: BolusDelivery? = nil,
                deliveryIndeterminant: Bool? = nil,
                reservoir: Reservoir? = nil) {
        self.basalDelivery = basalDelivery
        self.battery = battery
        self.bolusDelivery = bolusDelivery
        self.deliveryIndeterminant = deliveryIndeterminant
        self.reservoir = reservoir
        super.init(.pumpStatus, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.basalDelivery = try container.decodeIfPresent(BasalDelivery.self, forKey: .basalDelivery)
        self.battery = try container.decodeIfPresent(Battery.self, forKey: .battery)
        self.bolusDelivery = try container.decodeIfPresent(BolusDelivery.self, forKey: .bolusDelivery)
        self.deliveryIndeterminant = try container.decodeIfPresent(Bool.self, forKey: .deliveryIndeterminant)
        self.reservoir = try container.decodeIfPresent(Reservoir.self, forKey: .reservoir)
        try super.init(.pumpStatus, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(basalDelivery, forKey: .basalDelivery)
        try container.encodeIfPresent(battery, forKey: .battery)
        try container.encodeIfPresent(bolusDelivery, forKey: .bolusDelivery)
        try container.encodeIfPresent(deliveryIndeterminant, forKey: .deliveryIndeterminant)
        try container.encodeIfPresent(reservoir, forKey: .reservoir)
        try super.encode(to: encoder)
    }

    public struct BasalDelivery: Codable, Equatable {
        public enum State: String, Codable {
            case cancelingTemporary
            case initiatingTemporary
            case resuming
            case scheduled
            case suspended
            case suspending
            case temporary
        }

        public var state: State?
        public var time: Date?
        public var dose: Dose?

        public init(state: State, time: Date? = nil, dose: Dose? = nil) {
            self.state = state
            self.time = time
            self.dose = dose
        }

        public struct Dose: Codable, Equatable {
            public var startTime: Date?
            public var endTime: Date?
            public var rate: Double?
            public var amountDelivered: Double?

            public init(startTime: Date? = nil, endTime: Date? = nil, rate: Double, amountDelivered: Double? = nil) {
                self.startTime = startTime
                self.endTime = endTime
                self.rate = rate
                self.amountDelivered = amountDelivered
            }
        }
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

    public struct BolusDelivery: Codable, Equatable {
        public enum State: String, Codable {
            case canceling
            case delivering
            case initiating
            case none
        }

        public var state: State?
        public var dose: Dose?

        public init(state: State, dose: Dose? = nil) {
            self.state = state
            self.dose = dose
        }

        public struct Dose: Codable, Equatable {
            public var startTime: Date?
            public var amount: Double?
            public var amountDelivered: Double?

            public init(startTime: Date? = nil, amount: Double, amountDelivered: Double? = nil) {
                self.startTime = startTime
                self.amount = amount
                self.amountDelivered = amountDelivered
            }
        }
    }

    public struct Reservoir: Codable, Equatable {
        public typealias Units = TInsulin.Units

        public var time: Date?
        public var remaining: Double?
        public var units: Units?

        public init(time: Date? = nil, remaining: Double, units: Units = .units) {
            self.time = time
            self.remaining = remaining
            self.units = units
        }
    }

    private enum CodingKeys: String, CodingKey {
        case basalDelivery
        case battery
        case bolusDelivery
        case deliveryIndeterminant
        case reservoir
    }
}
