//
//  TCalibrationDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TCalibrationDeviceEventDatumTests: XCTestCase {
    static let calibrationDeviceEvent = TCalibrationDeviceEventDatum(time: Date.test, value: 123, units: .milligramsPerDeciliter)
    static let calibrationDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "calibration",
        "time": Date.testJSONString,
        "value": 123,
        "units": "mg/dL"
    ]
    
    func testInitializer() {
        let calibrationDeviceEvent = TCalibrationDeviceEventDatumTests.calibrationDeviceEvent
        XCTAssertEqual(calibrationDeviceEvent.value, 123)
        XCTAssertEqual(calibrationDeviceEvent.units, .milligramsPerDeciliter)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCalibrationDeviceEventDatumTests.calibrationDeviceEvent, TCalibrationDeviceEventDatumTests.calibrationDeviceEventJSONDictionary)
    }
}

extension TCalibrationDeviceEventDatum {
    func isEqual(to other: TCalibrationDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.value == other.value &&
            self.units == other.units
    }
}
