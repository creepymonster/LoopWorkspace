//
//  TPhysicalActivityDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 10/31/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TPhysicalActivityDatum: TDatum, Decodable {
    public enum ActivityType: String, Codable {
        case americanFootball
        case archery
        case australianFootball
        case badminton
        case barre
        case baseball
        case basketball
        case bowling
        case boxing
        case climbing
        case coreTraining
        case cricket
        case crossCountrySkiing
        case crossTraining
        case curling
        case cycling
        case dance
        case danceInspiredTraining
        case downhillSkiing
        case elliptical
        case equestrianSports
        case fencing
        case fishing
        case flexibility
        case functionalStrengthTraining
        case golf
        case gymnastics
        case handball
        case handCycling
        case highIntensityIntervalTraining
        case hiking
        case hockey
        case hunting
        case jumpRope
        case kickboxing
        case lacrosse
        case martialArts
        case mindAndBody
        case mixedCardio
        case mixedMetabolicCardioTraining
        case other
        case paddleSports
        case pilates
        case play
        case preparationAndRecovery
        case racquetball
        case rowing
        case rugby
        case running
        case sailing
        case skatingSports
        case snowboarding
        case snowSports
        case soccer
        case softball
        case squash
        case stairClimbing
        case stairs
        case stepTraining
        case surfingSports
        case swimming
        case tableTennis
        case taiChi
        case tennis
        case trackAndField
        case traditionalStrengthTraining
        case volleyball
        case walking
        case waterFitness
        case waterPolo
        case waterSports
        case wheelchairRunPace
        case wheelchairWalkPace
        case wrestling
        case yoga
    }

    public enum ReportedIntensity: String, Codable {
        case low
        case medium
        case high
    }

    public var name: String?
    public var aggregate: Bool?
    public var activityType: ActivityType?
    public var activityTypeOther: String?
    public var duration: Duration?
    public var distance: Distance?
    public var elevationChange: ElevationChange?
    public var flight: Flight?
    public var lap: Lap?
    public var step: Step?
    public var reportedIntensity: ReportedIntensity?
    public var energy: Energy?

    public init(time: Date, name: String? = nil, aggregate: Bool? = nil, activityType: ActivityType? = nil, activityTypeOther: String? = nil, duration: Duration? = nil, distance: Distance? = nil, elevationChange: ElevationChange? = nil, flight: Flight? = nil, lap: Lap? = nil, step: Step? = nil, reportedIntensity : ReportedIntensity? = nil, energy: Energy? = nil) {
        self.name = name
        self.aggregate = aggregate
        self.activityType = activityType
        self.activityTypeOther = activityTypeOther
        self.duration = duration
        self.distance = distance
        self.elevationChange = elevationChange
        self.flight = flight
        self.lap = lap
        self.step = step
        self.reportedIntensity = reportedIntensity
        self.energy = energy
        super.init(.physicalActivity, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.aggregate = try container.decodeIfPresent(Bool.self, forKey: .aggregate)
        self.activityType = try container.decodeIfPresent(ActivityType.self, forKey: .activityType)
        self.activityTypeOther = try container.decodeIfPresent(String.self, forKey: .activityTypeOther)
        self.duration = try container.decodeIfPresent(Duration.self, forKey: .duration)
        self.distance = try container.decodeIfPresent(Distance.self, forKey: .distance)
        self.elevationChange = try container.decodeIfPresent(ElevationChange.self, forKey: .elevationChange)
        self.flight = try container.decodeIfPresent(Flight.self, forKey: .flight)
        self.lap = try container.decodeIfPresent(Lap.self, forKey: .lap)
        self.step = try container.decodeIfPresent(Step.self, forKey: .step)
        self.reportedIntensity = try container.decodeIfPresent(ReportedIntensity.self, forKey: .reportedIntensity)
        self.energy = try container.decodeIfPresent(Energy.self, forKey: .energy)
        try super.init(.physicalActivity, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(aggregate, forKey: .aggregate)
        try container.encodeIfPresent(activityType, forKey: .activityType)
        try container.encodeIfPresent(activityTypeOther, forKey: .activityTypeOther)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(distance, forKey: .distance)
        try container.encodeIfPresent(elevationChange, forKey: .elevationChange)
        try container.encodeIfPresent(flight, forKey: .flight)
        try container.encodeIfPresent(lap, forKey: .lap)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(reportedIntensity, forKey: .reportedIntensity)
        try container.encodeIfPresent(energy, forKey: .energy)
        try super.encode(to: encoder)
    }

    public struct Duration: Codable, Equatable {
        public enum Units: String, Codable {
            case hours
            case minutes
            case seconds
        }

        public var value: Double?
        public var units: Units?

        public init(_ value: Double, _ units: Units) {
            self.value = value
            self.units = units
        }
    }

    public struct Distance: Codable, Equatable {
        public enum Units: String, Codable {
            case feet
            case kilometers
            case meters
            case miles
            case yards
        }

        public var value: Double?
        public var units: Units?

        public init(_ value: Double, _ units: Units) {
            self.value = value
            self.units = units
        }
    }

    public struct ElevationChange: Codable, Equatable {
        public enum Units: String, Codable {
            case feet
            case meters
        }

        public var value: Double?
        public var units: Units?

        public init(_ value: Double, _ units: Units) {
            self.value = value
            self.units = units
        }
    }

    public struct Flight: Codable, Equatable {
        public var count: Int?

        public init(count: Int) {
            self.count = count
        }
    }

    public struct Lap: Codable, Equatable {
        public var count: Int?
        public var distance: Distance?

        public init(_ count: Int, _ distance: Distance) {
            self.count = count
            self.distance = distance
        }
    }

    public struct Step: Codable, Equatable {
        public var count: Int?

        public init(count: Int) {
            self.count = count
        }
    }

    public struct Energy: Codable, Equatable {
        public enum Units: String, Codable {
            case calories
            case joules
            case kilocalories
            case kilojoules
        }

        public var value: Double?
        public var units: Units?

        public init(_ value: Double, _ units: Units) {
            self.value = value
            self.units = units
        }
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case aggregate
        case activityType
        case activityTypeOther
        case duration
        case distance
        case elevationChange
        case flight
        case lap
        case step
        case reportedIntensity
        case energy
    }
}
