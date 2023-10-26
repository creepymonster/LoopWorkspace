//
//  TAssociation.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/23/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

public struct TAssociation: Codable, Equatable {
    public enum AssociationType: String, Codable {
        case blob
        case datum
        case image
        case url
    }

    public var type: AssociationType?
    public var id: String?
    public var url: String?
    public var reason: String?

    public init(type: AssociationType, id: String, reason: String? = nil) {
        self.type = type
        self.id = id
        self.reason = reason
    }

    public init(type: AssociationType, url: String, reason: String? = nil) {
        self.type = type
        self.url = url
        self.reason = reason
    }
}
