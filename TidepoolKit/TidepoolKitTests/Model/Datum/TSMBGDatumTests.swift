//
//  TSMBGDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TSMBGDatumTests: XCTestCase {
    static let smbg = TSMBGDatum(time: Date.test, value: 1.23, units: .milligramsPerDeciliter, subType: .manual)
    static let smbgJSONDictionary: [String: Any] = [
        "type": "smbg",
        "time": Date.testJSONString,
        "value": 1.23,
        "units": "mg/dL",
        "subType": "manual"
    ]
    
    func testInitializer() {
        let smbg = TSMBGDatumTests.smbg
        XCTAssertEqual(smbg.value, 1.23)
        XCTAssertEqual(smbg.units, .milligramsPerDeciliter)
        XCTAssertEqual(smbg.subType, .manual)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TSMBGDatumTests.smbg, TSMBGDatumTests.smbgJSONDictionary)
    }
}

class TSMBGDatumSubTypeTests: XCTestCase {
    func testSubType() {
        XCTAssertEqual(TSMBGDatum.SubType.linked.rawValue, "linked")
        XCTAssertEqual(TSMBGDatum.SubType.manual.rawValue, "manual")
        XCTAssertEqual(TSMBGDatum.SubType.scanned.rawValue, "scanned")
    }
}

extension TSMBGDatum {
    func isEqual(to other: TSMBGDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.value == other.value &&
            self.units == other.units &&
            self.subType == other.subType
    }
}
