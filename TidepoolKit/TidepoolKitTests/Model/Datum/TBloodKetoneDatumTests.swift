//
//  TBloodKetoneDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/6/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TBloodKetoneDatumTests: XCTestCase {
    static let bloodKetone = TBloodKetoneDatum(time: Date.test, value: 1.23)
    static let bloodKetoneJSONDictionary: [String: Any] = [
        "type": "bloodKetone",
        "time": Date.testJSONString,
        "value": 1.23,
        "units": "mmol/L"
    ]
    
    func testInitializer() {
        let bloodKetone = TBloodKetoneDatumTests.bloodKetone
        XCTAssertEqual(bloodKetone.value, 1.23)
        XCTAssertEqual(bloodKetone.units, .millimolesPerLiter)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TBloodKetoneDatumTests.bloodKetone, TBloodKetoneDatumTests.bloodKetoneJSONDictionary)
    }
}

class TBloodKetoneDatumUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TBloodKetoneDatum.Units.millimolesPerLiter.rawValue, "mmol/L")
    }
}

extension TBloodKetoneDatum {
    func isEqual(to other: TBloodKetoneDatum) -> Bool {
        super.isEqual(to: other) &&
            self.value == other.value &&
            self.units == other.units
    }
}
