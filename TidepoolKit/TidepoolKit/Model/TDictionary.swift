//
//  TDictionary.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

public struct TDictionary {
    public var dictionary: [String: Any]

    public init(_ dictionary: [String: Any] = [:]) {
        self.dictionary = dictionary
    }

    public var isEmpty: Bool { dictionary.isEmpty }

    public subscript(key: String) -> Any? {
        get { dictionary[key] }
        set(newValue) { dictionary[key] = newValue }
    }
}

extension TDictionary: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONCodingKeys.self)
        self.dictionary = try container.decode([String: Any].self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: JSONCodingKeys.self)
        try container.encode(dictionary)
    }
}

extension TDictionary: Equatable {
    public static func == (lhs: TDictionary, rhs: TDictionary) -> Bool {
        return NSDictionary(dictionary: lhs.dictionary).isEqual(to: rhs.dictionary)
    }
}
