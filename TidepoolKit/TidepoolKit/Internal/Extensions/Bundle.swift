//
//  Bundle.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/19/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

extension Bundle {
    var userAgent: String {
        var userAgent = bundleExecutable?.replacingOccurrences(of: " ", with: "-") ?? "Unknown"

        if let bundleShortVersionString = bundleShortVersionString, !bundleShortVersionString.isEmpty {
            userAgent = "\(userAgent)/\(bundleShortVersionString)"
        }

        let comments = [bundleIdentifier, bundleVersion].compactMap({ $0?.isEmpty == false ? $0 : nil }).joined(separator: "; ")
        if !comments.isEmpty {
            userAgent = "\(userAgent) (\(comments))"
        }

        return userAgent
    }

    var bundleExecutable: String? { string(forInfoDictionaryKey: "CFBundleExecutable") }

    var bundleShortVersionString: String? { string(forInfoDictionaryKey: "CFBundleShortVersionString") }

    var bundleVersion: String? { string(forInfoDictionaryKey: "CFBundleVersion") }

    func string(forInfoDictionaryKey key: String) -> String? { object(forInfoDictionaryKey: key) as? String }
}
