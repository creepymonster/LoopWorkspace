//
//  TSuspendedBasalDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TSuspendedBasalDatumTests: XCTestCase {
    static let suspendedBasal = TSuspendedBasalDatum(time: Date.test,
                                                     duration: 123.456,
                                                     expectedDuration: 234.567,
                                                     suppressed: TTemporaryBasalDatumSuppressedTests.suppressed)
    static let suspendedBasalJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "suspend",
        "time": Date.testJSONString,
        "duration": 123456,
        "expectedDuration": 234567,
        "suppressed": TTemporaryBasalDatumSuppressedTests.suppressedJSONDictionary
    ]
    
    func testInitializer() {
        let suspendedBasal = TSuspendedBasalDatumTests.suspendedBasal
        XCTAssertEqual(suspendedBasal.duration, 123.456)
        XCTAssertEqual(suspendedBasal.expectedDuration, 234.567)
        XCTAssertEqual(suspendedBasal.suppressed, TTemporaryBasalDatumSuppressedTests.suppressed)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TSuspendedBasalDatumTests.suspendedBasal, TSuspendedBasalDatumTests.suspendedBasalJSONDictionary)
    }
}

extension TSuspendedBasalDatum {
    func isEqual(to other: TSuspendedBasalDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.suppressed == other.suppressed
    }
}
