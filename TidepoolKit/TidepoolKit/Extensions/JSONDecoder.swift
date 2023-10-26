//
//  JSONDecoder.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/25/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    static var tidepool: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .tidepool
        return decoder
    }
}

public extension JSONDecoder.DateDecodingStrategy {
    static var tidepool: JSONDecoder.DateDecodingStrategy {
        return .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            guard let date = Date(timeString: string) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected date string '\(string)' to be Tidepool ISO8601-formatted.")
            }
            return date
        }
    }
}
