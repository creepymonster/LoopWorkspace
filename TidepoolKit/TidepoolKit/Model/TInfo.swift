//
//  TInfo.swift
//  TidepoolKit
//
//  Created by Rick Pasetto on 9/7/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

public struct TInfo: Codable, Equatable {
    public var versions: Versions?

    public struct Versions: Codable, Equatable {
        public var loop: Loop?

        public struct Loop: Codable, Equatable {
            public var minimumSupported: String?
            public var criticalUpdateNeeded: [String]?
        }
    }
}
