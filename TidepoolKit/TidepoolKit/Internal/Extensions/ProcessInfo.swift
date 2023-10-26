//
//  ProcessInfo.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/19/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

extension ProcessInfo {
    var userAgent: String {
        let version = operatingSystemVersion
        return "\(os)/\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    }

    var os: String {
        #if os(iOS)
        return "iOS"
        #elseif os(macOS)
        return "macOS"
        #elseif os(tvOS)
        return "tvOS"
        #elseif os(watchOS)
        return "watchOS"
        #elseif os(Linux)
        return "Linux"
        #else
        return "Unknown"
        #endif
    }
}
