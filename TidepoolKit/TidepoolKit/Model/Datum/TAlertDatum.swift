//
//  TAlertDatum.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/1/22.
//  Copyright © 2022 Tidepool Project. All rights reserved.
//

import Foundation

public class TAlertDatum: TDatum, Decodable {
    public enum Priority: String, Codable {
        case critical
        case normal
        case timeSensitive
    }

    public enum Sound: String, Codable {
        case name
        case silence
        case vibrate
    }

    public enum Trigger: String, Codable {
        case delayed
        case immediate
        case repeating
    }
    
    public var name: String?
    public var priority: Priority?
    public var trigger: Trigger?
    public var triggerDelay: TimeInterval?
    public var sound: Sound?
    public var soundName: String?
    public var issuedTime: Date?
    public var acknowledgedTime: Date?
    public var retractedTime: Date?

    public init(time: Date,
                name: String,
                priority: Priority? = nil,
                trigger: Trigger? = nil,
                triggerDelay: TimeInterval? = nil,
                sound: Sound? = nil,
                soundName: String? = nil,
                issuedTime: Date? = nil,
                acknowledgedTime: Date? = nil,
                retractedTime: Date? = nil) {
        self.name = name
        self.priority = priority
        self.trigger = trigger
        self.triggerDelay = triggerDelay
        self.sound = sound
        self.soundName = soundName
        self.issuedTime = issuedTime
        self.acknowledgedTime = acknowledgedTime
        self.retractedTime = retractedTime
        super.init(.alert, time: time)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.priority = try container.decodeIfPresent(Priority.self, forKey: .priority)
        self.trigger = try container.decodeIfPresent(Trigger.self, forKey: .trigger)
        self.triggerDelay = try container.decodeIfPresent(Int.self, forKey: .triggerDelay).map { .seconds($0) }
        self.sound = try container.decodeIfPresent(Sound.self, forKey: .sound)
        self.soundName = try container.decodeIfPresent(String.self, forKey: .soundName)
        self.issuedTime = try container.decodeIfPresent(Date.self, forKey: .issuedTime)
        self.acknowledgedTime = try container.decodeIfPresent(Date.self, forKey: .acknowledgedTime)
        self.retractedTime = try container.decodeIfPresent(Date.self, forKey: .retractedTime)
        try super.init(.alert, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(trigger, forKey: .trigger)
        try container.encodeIfPresent(triggerDelay.map { Int($0.seconds) }, forKey: .triggerDelay)
        try container.encodeIfPresent(sound, forKey: .sound)
        try container.encodeIfPresent(soundName, forKey: .soundName)
        try container.encodeIfPresent(issuedTime, forKey: .issuedTime)
        try container.encodeIfPresent(acknowledgedTime, forKey: .acknowledgedTime)
        try container.encodeIfPresent(retractedTime, forKey: .retractedTime)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case priority
        case trigger
        case triggerDelay
        case sound
        case soundName
        case issuedTime
        case acknowledgedTime
        case retractedTime
    }
}
