//
//  TStatusDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TStatusDeviceEventDatumTests: XCTestCase {
    static let statusDeviceEvent = TStatusDeviceEventDatum(time: Date.test,
                                                           name: .suspended,
                                                           duration: 123.456,
                                                           expectedDuration: 234.567,
                                                           reason: TDictionary(["One": 2, "a": "b"]))
    static let statusDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "status",
        "time": Date.testJSONString,
        "status": "suspended",
        "duration": 123456,
        "expectedDuration": 234567,
        "reason": ["One": 2, "a": "b"]
    ]
    
    func testInitializer() {
        let statusDeviceEvent = TStatusDeviceEventDatumTests.statusDeviceEvent
        XCTAssertEqual(statusDeviceEvent.name, .suspended)
        XCTAssertEqual(statusDeviceEvent.duration, 123.456)
        XCTAssertEqual(statusDeviceEvent.expectedDuration, 234.567)
        XCTAssertEqual(statusDeviceEvent.reason, TDictionary(["One": 2, "a": "b"]))
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TStatusDeviceEventDatumTests.statusDeviceEvent, TStatusDeviceEventDatumTests.statusDeviceEventJSONDictionary)
    }
}

extension TStatusDeviceEventDatum {
    func isEqual(to other: TStatusDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.name == other.name &&
            self.duration == other.duration &&
            self.expectedDuration == other.expectedDuration &&
            self.reason == other.reason
    }
}
