//
//  TNormalBolusDatum.swift
//  TidepoolKit
//
//  Created by Larry Kenyon on 8/30/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import Foundation

public class TNormalBolusDatum: TBolusDatum, Decodable {
    public var normal: Double?
    public var expectedNormal: Double?

    public init(time: Date, normal: Double, expectedNormal: Double? = nil, insulinFormulation: InsulinFormulation? = nil) {
        self.normal = normal
        self.expectedNormal = expectedNormal
        super.init(.normal, time: time, insulinFormulation: insulinFormulation)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.normal = try container.decodeIfPresent(Double.self, forKey: .normal)
        self.expectedNormal = try container.decodeIfPresent(Double.self, forKey: .expectedNormal)
        try super.init(.normal, from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(normal, forKey: .normal)
        try container.encodeIfPresent(expectedNormal, forKey: .expectedNormal)
        try super.encode(to: encoder)
    }

    private enum CodingKeys: String, CodingKey {
        case normal
        case expectedNormal
    }
}
