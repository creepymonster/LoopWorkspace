//
//  TInsulinTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/9/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TInsulinUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TInsulin.Units.units.rawValue, "Units")
    }

    func testRateUnits() {
        XCTAssertEqual(TInsulin.RateUnits.unitsPerHour.rawValue, "Units/hour")
    }
}
