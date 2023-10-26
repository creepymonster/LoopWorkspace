//
//  Bundle.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/25/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

extension Bundle {
    var semanticVersion: String? {
        guard var semanticVersion = bundleShortVersionString else {
            return nil
        }
        while semanticVersion.split(separator: ".").count < 3 {
            semanticVersion += ".0"
        }
        if let bundleVersion = bundleVersion {
            semanticVersion += "+\(bundleVersion)"
        }
        return semanticVersion
    }

    var bundleShortVersionString: String? { string(forInfoDictionaryKey: "CFBundleShortVersionString") }

    var bundleVersion: String? { string(forInfoDictionaryKey: "CFBundleVersion") }

    private func string(forInfoDictionaryKey key: String) -> String? { object(forInfoDictionaryKey: key) as? String }
}
