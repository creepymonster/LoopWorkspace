//
//  TDataSet.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/20/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public struct TDataSet: Codable, Equatable {
    public enum DataSetType: String, Codable {
        case continuous
        case normal
    }

    public enum DeviceTag: String, Codable {
        case bgm
        case cgm
        case insulinPump = "insulin-pump"
    }

    public enum TimeProcessing: String, Codable {
        case acrossTheBoardTimezone = "across-the-board-timezone"
        case none
        case utcBootstrapping = "utc-bootstrapping"
    }

    public var byUser: String?
    public var client: Client?
    public var computerTime: String?
    public var conversionOffset: TimeInterval?
    public var createdTime: Date?
    public var dataSetType: DataSetType?
    public var deduplicator: Deduplicator?
    public var deviceId: String?
    public var deviceManufacturers: [String]?
    public var deviceModel: String?
    public var deviceSerialNumber: String?
    public var deviceTags: [DeviceTag]?
    public var id: String?
    public var modifiedTime: Date?
    public var time: Date?
    public var timeProcessing: TimeProcessing?
    public var timezone: String?
    public var timezoneOffset: TimeInterval?
    public let type: String
    public var uploadId: String?
    public var version: String?

    public init(dataSetType: DataSetType, client: Client, deduplicator: Deduplicator) {
        self.dataSetType = dataSetType
        self.client = client
        self.deduplicator = deduplicator
        self.type = "upload"
    }

    public init(byUser: String? = nil,
                client: Client? = nil,
                computerTime: String? = nil,
                conversionOffset: TimeInterval? = nil,
                createdTime: Date? = nil,
                dataSetType: DataSetType? = nil,
                deduplicator: Deduplicator? = nil,
                deviceId: String? = nil,
                deviceManufacturers: [String]? = nil,
                deviceModel: String? = nil,
                deviceSerialNumber: String? = nil,
                deviceTags: [DeviceTag]? = nil,
                id: String? = nil,
                modifiedTime: Date? = nil,
                time: Date? = nil,
                timeProcessing: TimeProcessing? = nil,
                timezone: String? = nil,
                timezoneOffset: TimeInterval? = nil,
                uploadId: String? = nil,
                version: String? = nil) {
        self.byUser = byUser
        self.client = client
        self.computerTime = computerTime
        self.conversionOffset = conversionOffset
        self.createdTime = createdTime
        self.dataSetType = dataSetType
        self.deduplicator = deduplicator
        self.deviceId = deviceId
        self.deviceManufacturers = deviceManufacturers
        self.deviceModel = deviceModel
        self.deviceSerialNumber = deviceSerialNumber
        self.deviceTags = deviceTags
        self.id = id
        self.modifiedTime = modifiedTime
        self.time = time
        self.timeProcessing = timeProcessing
        self.timezone = timezone
        self.timezoneOffset = timezoneOffset
        self.type = "upload"
        self.uploadId = uploadId
        self.version = version
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.byUser = try container.decodeIfPresent(String.self, forKey: .byUser)
        self.client = try container.decodeIfPresent(Client.self, forKey: .client)
        self.computerTime = try container.decodeIfPresent(String.self, forKey: .computerTime)
        self.conversionOffset = try container.decodeIfPresent(Int.self, forKey: .conversionOffset).map { .milliseconds($0) }
        self.createdTime = try container.decodeIfPresent(Date.self, forKey: .createdTime)
        self.dataSetType = try container.decodeIfPresent(DataSetType.self, forKey: .dataSetType)
        self.deduplicator = try container.decodeIfPresent(Deduplicator.self, forKey: .deduplicator)
        self.deviceId = try container.decodeIfPresent(String.self, forKey: .deviceId)
        self.deviceManufacturers = try container.decodeIfPresent([String].self, forKey: .deviceManufacturers)
        self.deviceModel = try container.decodeIfPresent(String.self, forKey: .deviceModel)
        self.deviceSerialNumber = try container.decodeIfPresent(String.self, forKey: .deviceSerialNumber)
        self.deviceTags = try container.decodeIfPresent([DeviceTag].self, forKey: .deviceTags)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.modifiedTime = try container.decodeIfPresent(Date.self, forKey: .modifiedTime)
        self.time = try container.decodeIfPresent(Date.self, forKey: .time)
        self.timeProcessing = try container.decodeIfPresent(TimeProcessing.self, forKey: .timeProcessing)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.timezoneOffset = try container.decodeIfPresent(Int.self, forKey: .timezoneOffset).map { .minutes($0) }
        self.type = try container.decode(String.self, forKey: .type)
        self.uploadId = try container.decodeIfPresent(String.self, forKey: .uploadId)
        self.version = try container.decodeIfPresent(String.self, forKey: .version)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(byUser, forKey: .byUser)
        try container.encodeIfPresent(client, forKey: .client)
        try container.encodeIfPresent(computerTime, forKey: .computerTime)
        try container.encodeIfPresent(conversionOffset.map { Int($0.milliseconds) }, forKey: .conversionOffset)
        try container.encodeIfPresent(createdTime, forKey: .createdTime)
        try container.encodeIfPresent(dataSetType, forKey: .dataSetType)
        try container.encodeIfPresent(deduplicator, forKey: .deduplicator)
        try container.encodeIfPresent(deviceId, forKey: .deviceId)
        try container.encodeIfPresent(deviceManufacturers, forKey: .deviceManufacturers)
        try container.encodeIfPresent(deviceModel, forKey: .deviceModel)
        try container.encodeIfPresent(deviceSerialNumber, forKey: .deviceSerialNumber)
        try container.encodeIfPresent(deviceTags, forKey: .deviceTags)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(modifiedTime, forKey: .modifiedTime)
        try container.encodeIfPresent(time, forKey: .time)
        try container.encodeIfPresent(timeProcessing, forKey: .timeProcessing)
        try container.encodeIfPresent(timezone, forKey: .timezone)
        try container.encodeIfPresent(timezoneOffset.map { Int($0.minutes) }, forKey: .timezoneOffset)
        try container.encode(type, forKey: .type)
        try container.encodeIfPresent(uploadId, forKey: .uploadId)
        try container.encodeIfPresent(version, forKey: .version)
    }

    public struct Client: Codable, Equatable {
        public var name: String?
        public var version: String?
        public var payload: TDictionary?

        public init(name: String, version: String, payload: TDictionary? = nil) {
            self.name = name
            self.version = version
            self.payload = payload
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case version
            case payload = "private"
        }
    }

    public struct Deduplicator: Codable, Equatable {
        public enum Name: String, Codable {
            case dataSetDeleteOrigin = "org.tidepool.deduplicator.dataset.delete.origin"
            case deviceDeactivateHash = "org.tidepool.deduplicator.device.deactivate.hash"
            case deviceTruncateDataSet = "org.tidepool.deduplicator.device.truncate.dataset"
            case none = "org.tidepool.deduplicator.none"

            public init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                let nameRawValue = try container.decode(String.self)
                if let name = Name(rawValue: nameRawValue) {
                    self = name
                } else if let name = legacyNames[nameRawValue] {
                    self = name
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown name '\(nameRawValue)'")
                }
            }
        }

        public var name: Name
        public var version: String?

        public init(name: Name, version: String? = nil) {
            self.name = name
            self.version = version
        }

        private static let legacyNames: [String: Name] = [
            "org.tidepool.continuous.origin": .dataSetDeleteOrigin,
            "org.tidepool.hash-deactivate-old": .deviceDeactivateHash,
            "org.tidepool.truncate": .deviceTruncateDataSet,
            "org.tidepool.continuous": .none
        ]
    }

    private enum CodingKeys: String, CodingKey {
        case byUser
        case client
        case computerTime
        case conversionOffset
        case createdTime
        case dataSetType
        case deduplicator
        case deviceId
        case deviceManufacturers
        case deviceModel
        case deviceSerialNumber
        case deviceTags
        case id
        case modifiedTime
        case time
        case timeProcessing
        case timezone
        case timezoneOffset
        case type
        case uploadId
        case version
    }
}

extension TDataSet {
    public struct Filter {
        public var clientName: String?
        public var deleted: Bool?
        public var deviceId: String?

        public init(clientName: String? = nil, deleted: Bool? = nil, deviceId: String? = nil) {
            self.clientName = clientName
            self.deleted = deleted
            self.deviceId = deviceId
        }

        public var queryItems: [URLQueryItem]? {
            var queryItems: [URLQueryItem] = []
            if let clientName = clientName {
                queryItems.append(URLQueryItem(name: "client.name", value: clientName))
            }
            if let deleted = deleted {
                queryItems.append(URLQueryItem(name: "deleted", value: deleted.description))
            }
            if let deviceId = deviceId {
                queryItems.append(URLQueryItem(name: "deviceId", value: deviceId))
            }
            return queryItems
        }
    }
}
