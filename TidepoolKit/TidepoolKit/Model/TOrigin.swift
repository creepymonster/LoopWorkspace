//
//  TOrigin.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/23/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public struct TOrigin: Codable, Equatable {
    public enum OriginType: String, Codable {
        case application
        case device
        case manual
        case service
    }

    public var id: String?
    public var name: String?
    public var version: String?
    public var type: OriginType?
    public var time: Date?
    public var payload: TDictionary?

    public init(id: String? = nil, name: String? = nil, version: String? = nil, type: OriginType? = nil, time: Date? = nil, payload: TDictionary? = nil) {
        self.id = id
        self.name = name
        self.version = version
        self.type = type
        self.time = time
        self.payload = payload
    }
}
