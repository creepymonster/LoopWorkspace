//
//  TPrimeDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPrimeDeviceEventDatumTests: XCTestCase {
    static let primeDeviceEvent = TPrimeDeviceEventDatum(time: Date.test, volume: 1.23, target: .tubing)
    static let primeDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "prime",
        "time": Date.testJSONString,
        "volume": 1.23,
        "primeTarget": "tubing"
    ]
    
    func testInitializer() {
        let primeDeviceEvent = TPrimeDeviceEventDatumTests.primeDeviceEvent
        XCTAssertEqual(primeDeviceEvent.volume, 1.23)
        XCTAssertEqual(primeDeviceEvent.target, .tubing)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrimeDeviceEventDatumTests.primeDeviceEvent, TPrimeDeviceEventDatumTests.primeDeviceEventJSONDictionary)
    }
}

class TPrimeDeviceEventDatumTargetTests: XCTestCase {
    func testTarget() {
        XCTAssertEqual(TPrimeDeviceEventDatum.Target.cannula.rawValue, "cannula")
        XCTAssertEqual(TPrimeDeviceEventDatum.Target.tubing.rawValue, "tubing")
    }
}

extension TPrimeDeviceEventDatum {
    func isEqual(to other: TPrimeDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.volume == other.volume &&
            self.target == other.target
    }
}
