//
//  TControllerSettingsDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 11/3/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import Foundation

public class TControllerSettingsDatum: TDatum, Decodable {
    public var device: Device?
    public var notifications: Notifications?

    public init(time: Date, device: Device? = nil, notifications: Notifications? = nil) {
        self.device = device
        self.notifications = notifications
        super.init(.controllerSettings, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.device = try container.decodeIfPresent(Device.self, forKey: .device)
        self.notifications = try container.decodeIfPresent(Notifications.self, forKey: .notifications)
        try super.init(.controllerSettings, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(device, forKey: .device)
        try container.encodeIfPresent(notifications, forKey: .notifications)
        try super.encode(to: encoder)
    }

    public struct Device: Codable, Equatable {
        public var firmwareVersion: String?
        public var hardwareVersion: String?
        public var manufacturers: [String]?
        public var model: String?
        public var name: String?
        public var serialNumber: String?
        public var softwareVersion: String?

        public init(firmwareVersion: String? = nil,
                    hardwareVersion: String? = nil,
                    manufacturers: [String]? = nil,
                    model: String? = nil,
                    name: String? = nil,
                    serialNumber: String? = nil,
                    softwareVersion: String? = nil) {
            self.firmwareVersion = firmwareVersion
            self.hardwareVersion = hardwareVersion
            self.manufacturers = manufacturers
            self.model = model
            self.name = name
            self.serialNumber = serialNumber
            self.softwareVersion = softwareVersion
        }
    }

    public struct Notifications: Codable, Equatable {
        public enum Authorization: String, Codable {
            case notDetermined
            case denied
            case authorized
            case provisional
            case ephemeral
        }

        public enum AlertStyle: String, Codable {
            case none
            case alert
            case banner
        }

        public let authorization: Authorization?
        public let alert: Bool?
        public let criticalAlert: Bool?
        public let badge: Bool?
        public let sound: Bool?
        public let announcement: Bool?
        public let timeSensitive: Bool?
        public let scheduledDelivery: Bool?
        public let notificationCenter: Bool?
        public let lockScreen: Bool?
        public let alertStyle: AlertStyle?

        public init(authorization: Authorization? = nil,
                    alert: Bool? = nil,
                    criticalAlert: Bool? = nil,
                    badge: Bool? = nil,
                    sound: Bool? = nil,
                    announcement: Bool? = nil,
                    timeSensitive: Bool? = nil,
                    scheduledDelivery: Bool? = nil,
                    notificationCenter: Bool? = nil,
                    lockScreen: Bool? = nil,
                    alertStyle: AlertStyle? = nil) {
            self.authorization = authorization
            self.alert = alert
            self.criticalAlert = criticalAlert
            self.badge = badge
            self.sound = sound
            self.announcement = announcement
            self.timeSensitive = timeSensitive
            self.scheduledDelivery = scheduledDelivery
            self.notificationCenter = notificationCenter
            self.lockScreen = lockScreen
            self.alertStyle = alertStyle
        }
    }

    private enum CodingKeys: String, CodingKey {
        case device
        case notifications
    }
}
