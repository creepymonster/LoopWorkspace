//
//  TLocation.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/23/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

public struct TLocation: Codable, Equatable {
    public var name: String?
    public var gps: GPS?

    public init(name: String? = nil, gps: GPS? = nil) {
        self.name = name
        self.gps = gps
    }

    public struct GPS: Codable, Equatable {
        public var latitude: Latitude?
        public var longitude: Longitude?
        public var elevation: Elevation?
        public var floor: Int?
        public var horizontalAccuracy: Accuracy?
        public var verticalAccuracy: Accuracy?
        public var origin: TOrigin?

        public init(latitude: Latitude? = nil, longitude: Longitude? = nil, elevation: Elevation? = nil, floor: Int? = nil, horizontalAccuracy: Accuracy? = nil, verticalAccuracy: Accuracy? = nil, origin: TOrigin? = nil) {
            self.latitude = latitude
            self.longitude = longitude
            self.elevation = elevation
            self.floor = floor
            self.horizontalAccuracy = horizontalAccuracy
            self.verticalAccuracy = verticalAccuracy
            self.origin = origin
        }

        public struct Latitude: Codable, Equatable {
            public enum Units: String, Codable {
                case degrees
            }

            public var value: Double?
            public var units: Units?

            public init(_ value: Double, _ units: Units = .degrees) {
                self.value = value
                self.units = units
            }
        }

        public struct Longitude: Codable, Equatable {
            public enum Units: String, Codable {
                case degrees
            }

            public var value: Double?
            public var units: Units?

            public init(_ value: Double, _ units: Units = .degrees) {
                self.value = value
                self.units = units
            }
        }

        public struct Elevation: Codable, Equatable {
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

        public struct Accuracy: Codable, Equatable {
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
    }
}
