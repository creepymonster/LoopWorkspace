//
//  JSONEncoder.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    static var pretty: JSONEncoder {
        let encoder = JSONEncoder.tidepool
        encoder.outputFormatting.insert(.prettyPrinted)
        return encoder
    }
}
