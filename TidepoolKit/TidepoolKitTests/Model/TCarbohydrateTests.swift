//
//  TCarbohydrateTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/9/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TCarbohydrateUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TCarbohydrate.Units.grams.rawValue, "grams")
    }
}
