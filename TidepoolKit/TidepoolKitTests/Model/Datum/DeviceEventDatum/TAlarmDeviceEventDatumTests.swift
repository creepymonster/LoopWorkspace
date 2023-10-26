//
//  TAlarmDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TAlarmDeviceEventDatumTests: XCTestCase {
    static let alarmDeviceEvent = TAlarmDeviceEventDatum(time: Date.test, alarmType: .noInsulin)
    static let alarmDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "alarm",
        "time": Date.testJSONString,
        "alarmType": "no_insulin"
    ]
    
    func testInitializer() {
        let alarmDeviceEvent = TAlarmDeviceEventDatumTests.alarmDeviceEvent
        XCTAssertEqual(alarmDeviceEvent.alarmType, .noInsulin)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TAlarmDeviceEventDatumTests.alarmDeviceEvent, TAlarmDeviceEventDatumTests.alarmDeviceEventJSONDictionary)
    }
}

class TAlarmDeviceEventDatumAlarmTypeTests: XCTestCase {
    func testAlarmType() {
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.autoOff.rawValue, "auto_off")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.lowInsulin.rawValue, "low_insulin")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.lowPower.rawValue, "low_power")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.noDelivery.rawValue, "no_delivery")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.noInsulin.rawValue, "no_insulin")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.noPower.rawValue, "no_power")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.occlusion.rawValue, "occlusion")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.other.rawValue, "other")
        XCTAssertEqual(TAlarmDeviceEventDatum.AlarmType.overLimit.rawValue, "over_limit")
    }
}

extension TAlarmDeviceEventDatum {
    func isEqual(to other: TAlarmDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.alarmType == other.alarmType &&
            self.status == other.status &&
            self.statusId == other.statusId
    }
}
