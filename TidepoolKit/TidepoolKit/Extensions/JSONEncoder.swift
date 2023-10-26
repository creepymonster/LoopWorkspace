//
//  JSONEncoder.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/25/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    static var tidepool: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .tidepool
        return encoder
    }
}

public extension JSONEncoder.DateEncodingStrategy {
    static var tidepool: JSONEncoder.DateEncodingStrategy {
        return .custom { (date, encoder) in
            var encoder = encoder.singleValueContainer()
            try encoder.encode(date.timeString)
        }
    }
}
