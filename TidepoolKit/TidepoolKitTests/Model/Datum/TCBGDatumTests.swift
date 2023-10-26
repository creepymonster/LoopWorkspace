//
//  TCBGDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/6/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TCBGDatumTests: XCTestCase {
    static let cbg = TCBGDatum(time: Date.test,
                               value: 1.23,
                               units: .milligramsPerDeciliter,
                               trend: .slowRise,
                               trendRate: 1.1)
    static let cbgJSONDictionary: [String: Any] = [
        "type": "cbg",
        "time": Date.testJSONString,
        "value": 1.23,
        "units": "mg/dL",
        "trend": "slowRise",
        "trendRate": 1.1
    ]
    
    func testInitializer() {
        let cbg = TCBGDatumTests.cbg
        XCTAssertEqual(cbg.value, 1.23)
        XCTAssertEqual(cbg.units, .milligramsPerDeciliter)
        XCTAssertEqual(cbg.trend, .slowRise)
        XCTAssertEqual(cbg.trendRate, 1.1)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCBGDatumTests.cbg, TCBGDatumTests.cbgJSONDictionary)
    }
}

extension TCBGDatum {
    func isEqual(to other: TCBGDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.value == other.value &&
            self.units == other.units &&
            self.trend == other.trend &&
            self.trendRate == other.trendRate
    }
}
