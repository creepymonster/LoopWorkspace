//
//  TInsulin.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 3/9/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

public struct TInsulin {
    public enum Units: String, Codable {
        case units = "Units"
    }

    public enum RateUnits: String, Codable {
        case unitsPerHour = "Units/hour"
    }
}
