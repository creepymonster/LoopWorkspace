//
//  TDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TDeviceEventDatumTests: XCTestCase {
    static let deviceEvent = TDeviceEventDatum(.alarm, time: Date.test)
    static let deviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "alarm",
        "time": Date.testJSONString
    ]
    
    func testInitializer() {
        let deviceEvent = TDeviceEventDatumTests.deviceEvent
        XCTAssertEqual(deviceEvent.subType, .alarm)
    }
}

class TDeviceEventDatumSubTypeTests: XCTestCase {
    func testSubType() {
        XCTAssertEqual(TDeviceEventDatum.SubType.alarm.rawValue, "alarm")
        XCTAssertEqual(TDeviceEventDatum.SubType.calibration.rawValue, "calibration")
        XCTAssertEqual(TDeviceEventDatum.SubType.prime.rawValue, "prime")
        XCTAssertEqual(TDeviceEventDatum.SubType.pumpSettingsOverride.rawValue, "pumpSettingsOverride")
        XCTAssertEqual(TDeviceEventDatum.SubType.reservoirChange.rawValue, "reservoirChange")
        XCTAssertEqual(TDeviceEventDatum.SubType.status.rawValue, "status")
        XCTAssertEqual(TDeviceEventDatum.SubType.timeChange.rawValue, "timeChange")
    }
}

extension TDeviceEventDatum {
    func isEqual(to other: TDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.subType == other.subType
    }
}
